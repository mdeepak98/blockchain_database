<template>
  <div>
    <h2 class="mb-8 ml-8">BlockChain</h2>
    <v-card
      elevation="0"
      class="d-flex flex-wrap justify-space-around align-center"
    >
      <v-card
        class="ml-8 mb-8"
        v-for="(block, index) in blocks"
        :key="index"
        width="320"
        elevation="0"
      >
        <v-expansion-panels>
          <v-expansion-panel>
            <v-expansion-panel-header>
              <v-col>
                <h3 class="text-center">
                  {{ index == 0 ? 'Genesis Block' : `Block ${index}` }}
                </h3>
              </v-col>
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              <v-col>
                <v-row class="align-center">
                  <v-col cols="3" class="font-weight-bold pr-0">
                    Hash
                  </v-col>
                  <v-col cols="9">
                    <v-card
                      outlined
                      height="35"
                      class="pt-1"
                      style="white-space: nowrap;overflow: scroll;font-size: large"
                    >
                      {{ block.hash }}
                    </v-card>
                  </v-col>
                </v-row>
                <v-row class="align-center">
                  <v-col cols="3" class="font-weight-bold pr-0">
                    Previous Hash
                  </v-col>
                  <v-col cols="9">
                    <v-card
                      outlined
                      height="35"
                      class="pt-1"
                      style="white-space: nowrap;overflow: scroll;font-size: large"
                    >
                      {{ block.previous_hash }}
                    </v-card>
                  </v-col>
                </v-row>
                <v-row class="align-center">
                  <v-col cols="3" class="font-weight-bold pr-0">
                    Nonce
                  </v-col>
                  <v-col cols="9">
                    {{ block.nonce }}
                  </v-col>
                </v-row>
                <v-divider class="mt-8 mb-8"></v-divider>
                <h4 class="mb-2">Transactions</h4>
                <v-simple-table class="ml-8 mr-8">
                  <template v-slot:default>
                    <thead>
                      <tr>
                        <th class="text-left">
                          From
                        </th>
                        <th class="text-left">
                          To
                        </th>
                        <th class="text-left">
                          Amount
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td width="100" style="width:100px">User1</td>
                        <td style="width:100px">User2</td>
                        <td style="width:100px">2000</td>
                      </tr>
                    </tbody>
                  </template>
                </v-simple-table>
                <!-- </v-row> -->
                <v-row> </v-row>
                <v-row> </v-row>
              </v-col>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
        <!-- <v-col>
          <v-row class="align-center">
            <v-col cols="3" class="font-weight-bold pr-0">
              Hash
            </v-col>
            <v-col cols="9">
              <v-card
                outlined
                height="35"
                class="pt-1"
                style="white-space: nowrap;overflow: scroll;font-size: large"
              >
                {{ block.hash }}
              </v-card>
            </v-col>
          </v-row>
          <v-row class="align-center">
            <v-col cols="3" class="font-weight-bold pr-0">
              Previous Hash
            </v-col>
            <v-col cols="9">
              <v-card
                outlined
                height="35"
                class="pt-1"
                style="white-space: nowrap;overflow: scroll;font-size: large"
              >
                {{ block.previous_hash }}
              </v-card>
            </v-col>
          </v-row>
          <v-row class="align-center">
            <v-col cols="3" class="font-weight-bold pr-0">
              Nonce
            </v-col>
            <v-col cols="9">
              {{ block.nonce }}
            </v-col>
          </v-row>
          <v-divider class="mt-8 mb-8"></v-divider>
          <h4 class="mb-2">Transactions</h4>
          <v-simple-table class="ml-8 mr-8">
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left">
                    From
                  </th>
                  <th class="text-left">
                    To
                  </th>
                  <th class="text-left">
                    Amount
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td width="100" style="width:100px">User1</td>
                  <td style="width:100px">User2</td>
                  <td style="width:100px">2000</td>
                </tr>
              </tbody>
            </template>
          </v-simple-table>
        </v-col> -->
      </v-card>
    </v-card>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      blocks: [
        {
          transactions: [
            {
              from_address: null,
              to_address: 'Caratlane',
              amount: 10000000,
              timestamp: 1633540202,
            },
          ],
          timestamp: 1633540202,
          previous_hash: '0',
          hash:
            'eb3e313b125ad39cff04af9d32a7c967bbadc84b9dce63812467e65f6b5356b6',
          nonce: 0,
        },
      ],
      amount: null,
      amountRules: [v => /^\d+$/.test(v) || 'Enter valid amount'],
    };
  },
  // computed: {
  //   block() {
  //     return this.block;
  //   },
  // },
  mounted() {
    axios.get('/xclusive_ledger/block_chain').then(response => {
      this.blocks = response.data.chain;
    });
  },
  methods: {
    postTransaction: function() {
      let transactionDetails = {to: this.select, amount: this.amount};
      axios
        .post('/xclusive_ledger/add_transaction', transactionDetails)
        .then(response => {
          console.log('Response..............', response);
          this.$emit('mine');
        });
    },
  },
};
</script>
