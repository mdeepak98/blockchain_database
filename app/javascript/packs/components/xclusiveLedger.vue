<template>
  <v-col>
  <v-row>
  <v-card class="d-flex justify-space-around" elevation="0" width="100%">
    <v-card v-for="n in 1" :key="n" width="400" style="height:max-content;border: 1px solid purple">
      <v-card-title class="font-weight-bold purple white--text">
        Caratlane Xclusice Points Ledger
      </v-card-title>
      <v-data-table v-if="!isLoading"
        :headers="headers"
        :items="ledgerData"
        class="pl-8 pr-8"
      ></v-data-table>
      <v-card class="d-flex justify-space-around align-center" height="100" v-if="isLoading">
        <v-progress-circular
          indeterminate
          color="primary"
        ></v-progress-circular>
      </v-card>
    </v-card>
    <newtransaction @mine="mine"/>
    <transaction />
  </v-card>
  </v-row>
  <v-col>
    <block-chain/>
  </v-col>
  </v-col>
</template>

<script>
 import NewTransaction from './newTransaction.vue';
 import Transaction from './transaction.vue';
 import BlockChain from './blockChain.vue';
 import axios from 'axios';

  export default {
    data () {
      return {
        headers: [
          { text: 'Username', value: 'username' },
          { text: 'Xclusive Points', value: 'xclusive_points' },
        ],
        ledgerData: [],
      }
    },
    components: { newtransaction: NewTransaction, transaction: Transaction, blockChain: BlockChain },
    computed: {
      isLoading() { return this.ledgerData.length === 0 }
    },
    mounted () {
    axios
      .get('http://localhost:3000/xclusive_ledger')
      .then(response => {
        this.ledgerData = response.data})
    },
    methods: {
      mine: function(){
        console.log("Started mining.........");
        axios
        .get('http://localhost:3000/xclusive_ledger/mine')
        .then(response => {
          this.ledgerData = response.data
        })
      }
    }
  }
</script>