<template>
  <v-card width="500" height="300">
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
          >
            Add Transaction
          </v-btn>
        </div>

      </v-form>
    </v-card>
</template>

<script>
  export default {
    data () {
      return {
        select: null,
        items: [
          'Item 1',
          'Item 2',
          'Item 3',
          'Item 4',
        ],
        amount: null,
        amountRules: [
          v => /^\d+$/.test(v) || "Enter valid amount"
        ],
        search: ''
      }
    }
  }
</script>