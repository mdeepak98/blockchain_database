<template>
  <v-card
    style="height:550px; width:500px;border: 1px solid purple;overflow:hidden"
  >
    <v-col style="max-height:450px;overflow-y:scroll">
      <v-card-title class="font-weight-bold purple white--text text-center">
        Transactions
      </v-card-title>

      <v-timeline class="mt-4" light dense clipped>
        <v-timeline-item class="mb-2 mt-0" hide-dot>
          <span class="font-weight-bold">TODAY</span>
        </v-timeline-item>

        <v-timeline-item
          class="mb-2"
          color="grey"
          icon-color="grey"
          fill-dot
          small
          v-for="txn in transactionHistory"
          :key="txn.id"
        >
          <v-col class="mt-1 mb-1">
            <v-row>{{ txn.message }}</v-row>
            <v-row class="grey--text">{{ txn.created_at }}</v-row>
          </v-col>
        </v-timeline-item>
      </v-timeline>
    </v-col>
    <v-col class="pa-0 pt-0 ma-0" style="height:50px;background-color:#e2e0e0">
      <newtransaction @mine="mine" />
    </v-col>
  </v-card>
</template>

<script>
import axios from 'axios';
import NewTransactionVertical from './newTransactionVertical.vue';
export default {
  data: () => ({
    events: [],
    input: null,
    nonce: 0,
    transactionHistory: [
      {
        id: 1,
        message: 'Caratlane added 1 Crore points to its account',
        created_at: '1st Oct 2021',
      },
      {
        id: 2,
        message: 'User1 sent 10 Thousand points to User2',
        created_at: '2nd Oct 2021',
      },
      {
        id: 3,
        message: 'User2 sent Thousand points to User3',
        created_at: '1st Oct 2021',
      },
      {
        id: 4,
        message: 'Caratlane added 1 Crore points to its account',
        created_at: '1st Oct 2021',
      },
    ],
  }),

  components: {
    newtransaction: NewTransactionVertical,
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
    mine: function() {
      console.log('Started mining.........');
      axios.get('http://localhost:3000/xclusive_ledger/mine').then(response => {
        this.ledgerData = response.data;
      });
    },
  },
};
</script>
