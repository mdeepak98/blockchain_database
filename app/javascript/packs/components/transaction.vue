<template>
  <v-card
    style="max-width: 800px;max-height:350px;border: 1px solid purple;overflow-y:scroll"
  >
    <v-card-title class="font-weight-bold purple white--text text-center">
      Customer Transaction history
    </v-card-title>

    <v-timeline dense clipped>
      <v-slide-x-transition group>
        <v-timeline-item
          v-for="event in timeline"
          :key="event.id"
          class="mb-4"
          color="pink"
          small
        >
          <v-row justify="space-between">
            <v-col cols="7" v-text="event.text"></v-col>
            <v-col class="text-right" cols="5" v-text="event.time"></v-col>
          </v-row>
        </v-timeline-item>
      </v-slide-x-transition>

      <v-timeline-item class="mb-6" hide-dot>
        <span>TODAY</span>
      </v-timeline-item>

      <v-timeline-item
        class="mb-4"
        color="grey"
        icon-color="grey lighten-2"
        small
        v-for="txn in transactionHistory"
        :key="txn.id"
      >
        <v-row justify="space-between">
          <v-col cols="7">
            {{ txn.message }}
          </v-col>
          <v-col class="text-center" cols="5">
            {{ txn.createdAt }}
          </v-col>
        </v-row>
      </v-timeline-item>

      <v-timeline-item fill-dot class="white--text mb-12" color="orange" large>
        <template v-slot:icon>
          <span>JL</span>
        </template>
        <newtransaction />
        <!-- <v-text-field
          v-model="input"
          hide-details
          flat
          label="Leave a comment..."
          solo
          @keydown.enter="comment"
        >
          <template v-slot:append>
            <v-btn
              class="mx-0"
              depressed
              @click="comment"
            >
              Post
            </v-btn>
          </template>
        </v-text-field> -->
      </v-timeline-item>
    </v-timeline>
  </v-card>
</template>

<script>
import axios from 'axios';
import NewTransaction from './newTransaction.vue';
export default {
  data: () => ({
    events: [],
    input: null,
    nonce: 0,
    transactionHistory: [
      {
        id: 1,
        message: 'Caratlane added 1 Crore points to its account',
        createdAt: '1st Oct 2021',
      },
      {
        id: 2,
        message: 'User1 sent 10 Thousand points to User2',
        createdAt: '2nd Oct 2021',
      },
      {
        id: 3,
        message: 'User2 sent Thousand points to User3',
        createdAt: '1st Oct 2021',
      },
      {
        id: 4,
        message: 'Caratlane added 1 Crore points to its account',
        createdAt: '1st Oct 2021',
      },
    ],
  }),

  components: {
    newtransaction: NewTransaction,
  },

  computed: {
    timeline() {
      return this.events.slice().reverse();
    },
  },

  mounted() {
    axios
      .get('http://localhost:3000/xclusive_ledger/transaction_history')
      .then(response => {
        this.transactionHistory = response.data;
      });
  },

  methods: {
    comment() {
      const time = new Date().toTimeString();
      this.events.push({
        id: this.nonce++,
        text: this.input,
        time: time.replace(
          /:\d{2}\sGMT-\d{4}\s\((.*)\)/,
          (match, contents, offset) => {
            return ` ${contents
              .split(' ')
              .map(v => v.charAt(0))
              .join('')}`;
          },
        ),
      });

      this.input = null;
    },
  },
};
</script>
