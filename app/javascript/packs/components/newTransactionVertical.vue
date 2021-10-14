<template>
  <v-form
    ref="form"
    style="padding-top:20px;background-color:#e2e0e0"
    lazy-validation
    class="pl-4 pr-4"
  >
    <v-container>
      <v-row>
        <v-col class="pl-0 pr-0" cols="4">
          <v-text-field
            placeholder="1000"
            outlined
            dense
            :rules="amountRules"
            v-model="amount"
            label="Amount"
            required
          />
        </v-col>

        <v-col class="pr-0" cols="5">
          <v-select
            outlined
            dense
            v-model="select"
            :items="items"
            :rules="[v => !!v || 'Item is required']"
            label="To"
            required
          ></v-select>
        </v-col>

        <v-col cols="3">
          <v-btn
            style="width:80px;height:40px"
            class="font-weight-bold pl-0"
            dark
            outlined
            color="indigo"
            :loading="addingTransaction"
            @click="postTransaction"
          >
            Send
          </v-btn>
          <!-- <v-btn
            rounded
            color="purple"
            dark
            class="pa-6"
            @click="postTransaction"
          > -->
          <!-- <v-icon dark right @click="postTransaction">
                mdi-checkbox-marked-circle
              </v-icon> -->
          <!-- </v-btn> -->
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      addingTransaction: false,
      select: null,
      items: ['User1', 'User2', 'User3', 'User4'],
      amount: null,
      amountRules: [v => /^\d+$/.test(v) || 'Enter valid amount'],
    };
  },
  methods: {
    postTransaction: function() {
      this.addingTransaction = true;
      let transactionDetails = {to: this.select, amount: this.amount};
      axios
        .post('/xclusive_ledger/add_transaction', transactionDetails)
        .then(response => {
          console.log('Response..............', response);
          this.amount = null;
          this.select = null;
          // this.$emit('mine');
          this.addingTransaction = false;
        });
    },
  },
};
</script>
