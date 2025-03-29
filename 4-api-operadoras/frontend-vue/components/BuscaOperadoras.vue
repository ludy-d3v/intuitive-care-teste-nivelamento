<template>
  <div class="app">
    <header class="app-header">
      <img
        class="logo"
        src="https://media.licdn.com/dms/image/v2/C4D0BAQEv5BSBMbiuxA/company-logo_200_200/company-logo_200_200/0/1659207651266/intuitivecare_logo?e=2147483647&v=beta&t=-EOJW1Hr2kMwcOAYfnRIISnRMzpLNMGBcOaEcV8dCiM"
        alt="Logo Intuitive Care"
      />
      <div>
        <h1>Busca de Operadoras</h1>
        <p class="subtitle">Teste de nivelamento - Intuitive Care</p>
      </div>
    </header>

    <div class="search-area">
      <input
        v-model="query"
        id="busca-operadora"
        type="text"
        placeholder="Digite o nome ou a razão social da operadora..."
        @keyup.enter="buscarOperadoras"
      />
      <button @click="buscarOperadoras" :disabled="loading || !query.trim()">
        {{ loading ? 'Buscando...' : 'Buscar' }}
      </button>
    </div>

    <div v-if="loading" class="loading">Carregando...</div>

    <div v-if="operadoras.length" class="resultados">
      <h2>Resultados:</h2>
      <div class="cards">
        <div class="card" v-for="operadora in operadoras" :key="operadora.Registro_ANS">
          <h3>{{ operadora.Razao_Social || 'Desconhecido' }}</h3>
          <p><strong>Nome Fantasia:</strong> {{ operadora.Nome_Fantasia || 'Não informado' }}</p>
          <p><strong>CNPJ:</strong> {{ operadora.CNPJ || 'Não informado' }}</p>
          <p><strong>Telefone:</strong> ({{ operadora.DDD || 'XX' }}) {{ operadora.Telefone || 'Não informado' }}</p>
          <p><strong>UF:</strong> {{ operadora.UF || 'Não especificado' }}</p>
        </div>
      </div>
    </div>

    <p v-else-if="buscou && !operadoras.length" class="mensagem-vazia">
      Nenhuma operadora encontrada para a consulta "{{ query }}".
    </p>
    <p v-else class="mensagem-vazia">
      Digite algo no campo acima para buscar operadoras.
    </p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      query: '',
      operadoras: [],
      buscou: false,
      loading: false,
    };
  },
  methods: {
    async buscarOperadoras() {
      if (!this.query.trim()) {
        alert('Por favor, insira um termo para busca.');
        return;
      }
      this.loading = true;
      this.buscou = true;
      this.operadoras = [];

      try {
        const response = await axios.get('http://192.168.0.5:5000/search', {
          params: { query: this.query.trim() },
        });

        if (Array.isArray(response.data)) {
          this.operadoras = response.data
            .filter(op => op.Razao_Social && op.Registro_ANS !== "-1")
            .slice(0, 10);
        } else {
          console.error('Formato inesperado de dados:', response.data);
          alert('Erro: O servidor retornou um formato inesperado.');
        }
      } catch (error) {
        console.error('Erro ao buscar:', error.response?.data || error.message);
        alert('Erro ao buscar as operadoras. Verifique sua conexão ou tente novamente mais tarde.');
      } finally {
        this.loading = false;
      }
    },
  },
};
</script>

<style>
:root {
  --roxo-intuitive: #6A0DAD;
  --roxo-claro: #D8B4F8;
  --roxo-suave: #F3E8FF;
  --texto-escuro: #2D2D2D;
  --branco: #ffffff;
  --cinza-claro: #f5f5f5;
}

body {
  margin: 0;
  background-color: var(--roxo-suave);
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  color: var(--texto-escuro);
}

.app {
  max-width: 900px;
  margin: 2rem auto;
  padding: 2rem;
  background: var(--branco);
  border-radius: 16px;
  box-shadow: 0 6px 18px rgba(106, 13, 173, 0.15);
}

.app-header {
  text-align: center;
  margin-bottom: 2rem;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.logo {
  width: 60px;
  height: 60px;
  border-radius: 12px;
  object-fit: contain;
}

.app-header h1 {
  color: var(--roxo-intuitive);
  font-size: 2.2rem;
  margin-bottom: 0.2rem;
}

.subtitle {
  font-size: 1rem;
  color: #6a0dadbb;
}

.search-area {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 10px;
  margin-bottom: 2rem;
}

input {
  flex: 1;
  max-width: 400px;
  padding: 12px;
  border: 1px solid var(--roxo-claro);
  border-radius: 8px;
  font-size: 1rem;
  outline: none;
  transition: box-shadow 0.2s;
}

input:focus {
  box-shadow: 0 0 0 2px var(--roxo-claro);
}

button {
  padding: 12px 20px;
  background-color: var(--roxo-intuitive);
  color: white;
  border: none;
  border-radius: 8px;
  font-weight: bold;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

button:disabled {
  background-color: #c1a6db;
  cursor: not-allowed;
}

button:hover:enabled {
  background-color: #580e9e;
}

.loading {
  font-size: 1.2rem;
  font-weight: bold;
  color: #6A0DAD;
  text-align: center;
  margin-bottom: 1rem;
}

.resultados h2 {
  text-align: center;
  color: var(--texto-escuro);
  margin-bottom: 1.5rem;
}

.cards {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1.2rem;
}

.card {
  background-color: var(--roxo-suave);
  padding: 20px;
  border-radius: 12px;
  border: 1px solid var(--roxo-claro);
  box-shadow: 0 2px 8px rgba(106, 13, 173, 0.1);
  transition: transform 0.2s ease;
}

.card:hover {
  transform: translateY(-4px);
}

.card h3 {
  margin-top: 0;
  color: var(--roxo-intuitive);
  font-size: 1.2rem;
}

.card p {
  margin: 6px 0;
  color: var(--texto-escuro);
  font-size: 0.95rem;
}

.mensagem-vazia {
  text-align: center;
  color: #777;
  font-style: italic;
  margin-top: 2rem;
  font-size: 1rem;
}

@media (min-width: 600px) {
  .cards {
    grid-template-columns: 1fr 1fr;
  }
}
</style>