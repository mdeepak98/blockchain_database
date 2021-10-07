<template>
  <v-card width="500" height="300" style="border: 1px solid purple">
      <v-card-title class="font-weight-bold purple white--text">
        New transaction
      </v-card-title>
      <v-form
      ref="form"
      lazy-validation
      class="ml-4 mr-4"
      >

        <v-text-field
          v-model="amount"
          :rules="amountRules"
          label="Amount"
          required
        ></v-text-field>

        <v-select
          v-model="select"
          :items="items"
          :rules="[v => !!v || 'Item is required']"
          label="To"
          required
        ></v-select>

        <div class="text-center mt-6">
          <v-btn
            rounded
            color="purple"
            dark
            class="pa-6"
            @click="postTransaction"
          >
            Add Transaction
          </v-btn>
        </div>

      </v-form>
    </v-card>
</template>

<script>
 import axios from 'axios';
  export default {
    data () {
      return {
        select: null,
        items: [
          'User1',
          'User2',
          'User3',
          'User4',
        ],
        amount: null,
        amountRules: [
          v => /^\d+$/.test(v) || "Enter valid amount"
        ],
      }
    },
    methods: {
      postTransaction: function() {
        let transactionDetails = { to:  this.select, amount: this.amount}
        axios
        .post('/xclusive_ledger/add_transaction',transactionDetails)
        .then(response => { 
          console.log("Response..............",response); 
          this.$emit('mine')
        });
      }
    }
  }
</script>