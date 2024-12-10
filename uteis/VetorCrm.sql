--
-- PostgreSQL database dump
--

-- Dumped from database version 17.1
-- Dumped by pg_dump version 17.1

-- Started on 2024-11-18 17:38:22

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5052 (class 1262 OID 16386)
-- Name: vetorcrm; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE vetorcrm WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';


ALTER DATABASE vetorcrm OWNER TO postgres;

\connect vetorcrm

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 246 (class 1255 OID 16387)
-- Name: atualizar_todos_sequencias(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_todos_sequencias() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
    max_id INTEGER;
    seq_name TEXT;
BEGIN
    -- Percorre todas as tabelas no esquema public que possuem um campo serial ou bigserial como PK
    FOR rec IN
        SELECT table_name, column_name
        FROM information_schema.columns
        WHERE table_schema = 'public'  -- Esquema onde estão suas tabelas
          AND column_default LIKE 'nextval%'
          AND data_type IN ('serial', 'bigserial', 'integer')
    LOOP
        -- Obtém o nome da sequência associada ao campo serial
        seq_name := rec.table_name || '_' || rec.column_name || '_seq';
        
        -- Verifica se existem registros na tabela
        EXECUTE format('SELECT COUNT(*) FROM %I', rec.table_name) INTO max_id;
        
        IF max_id > 0 THEN
            -- Obtém o último valor da coluna PK da tabela atual
            EXECUTE format('SELECT MAX(%I) FROM %I', rec.column_name, rec.table_name) INTO max_id;
        ELSE
            max_id := 0;  -- Caso não haja registros, define max_id como 0 para iniciar em 1
        END IF;
        
        -- Atualiza a sequência para o próximo valor disponível
        EXECUTE format('ALTER SEQUENCE %I RESTART WITH %s', seq_name, max_id + 1);
        
        RAISE NOTICE 'Sequência % atualizada para começar com %', seq_name, max_id + 1;
    END LOOP;
END;
$$;


ALTER FUNCTION public.atualizar_todos_sequencias() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16388)
-- Name: t000api; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t000api (
    codapi integer NOT NULL,
    sisapi integer NOT NULL,
    desapi character varying(50) NOT NULL,
    srvhst character varying(50) NOT NULL,
    srvprt character varying(50) NOT NULL,
    nomusu character varying(50),
    senusu character varying(50),
    cgccpf character varying(18),
    unddis "char"
);


ALTER TABLE public.t000api OWNER TO postgres;

--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE t000api; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t000api IS 'Cadastro de APIs - Dados Gerais';


--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN t000api.codapi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000api.codapi IS 'Código da API';


--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN t000api.sisapi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000api.sisapi IS 'Sistema integrado pela API (0 - WhatsApp; 1 - ChSistemas)';


--
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN t000api.desapi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000api.desapi IS 'Descrição da API';


--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN t000api.srvhst; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000api.srvhst IS 'IP do Servidor Host da API';


--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN t000api.srvprt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000api.srvprt IS 'Porta do Servidor da API';


--
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN t000api.nomusu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000api.nomusu IS 'Nome do Usuário para autenticação na API';


--
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN t000api.senusu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000api.senusu IS 'Senha do Usuário para autenticação na API';


--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN t000api.cgccpf; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000api.cgccpf IS 'Número do CNPJ ou CPF da empresa que está autenticando na API';


--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN t000api.unddis; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000api.unddis IS 'Unidade do Disco Local onde esta instalado o ERP';


--
-- TOC entry 218 (class 1259 OID 16391)
-- Name: t000api_codapi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t000api_codapi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t000api_codapi_seq OWNER TO postgres;

--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 218
-- Name: t000api_codapi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t000api_codapi_seq OWNED BY public.t000api.codapi;


--
-- TOC entry 219 (class 1259 OID 16392)
-- Name: t000emp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t000emp (
    codapi integer NOT NULL,
    codemp integer NOT NULL,
    stareg character varying(1) NOT NULL,
    CONSTRAINT ck_stareg CHECK (((stareg)::text = ANY (ARRAY[('A'::character varying)::text, ('I'::character varying)::text])))
);


ALTER TABLE public.t000emp OWNER TO postgres;

--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE t000emp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t000emp IS 'Cadastro de APIs - Empresas';


--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN t000emp.codapi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000emp.codapi IS 'Código da API';


--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN t000emp.codemp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000emp.codemp IS 'Código da Empresa';


--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN t000emp.stareg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t000emp.stareg IS 'Status do registro (A = Ativo; I = Inativo)';


--
-- TOC entry 220 (class 1259 OID 16396)
-- Name: t001eva; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t001eva (
    codeva integer NOT NULL,
    tipeva integer NOT NULL,
    codmsg integer NOT NULL,
    qtddia integer NOT NULL,
    stareg character varying(1) NOT NULL,
    conenv integer,
    horini time without time zone,
    horfin time without time zone,
    envsbo integer,
    CONSTRAINT chk_stareg CHECK (((stareg)::text = ANY (ARRAY[('A'::character varying)::text, ('I'::character varying)::text])))
);


ALTER TABLE public.t001eva OWNER TO postgres;

--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE t001eva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t001eva IS 'Cadastro de envio automático de mensagens';


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN t001eva.codeva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t001eva.codeva IS 'Código do Envio automático';


--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN t001eva.tipeva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t001eva.tipeva IS 'Tipo de Envio Automatico (0 = Contas a Receber;  1 = Nota Fiscal - NFe; 2 = Nota Fiscal - NFSe; 3 = Boleto; 4 - Pós-venda)';


--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN t001eva.codmsg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t001eva.codmsg IS 'Código da Mensagem';


--
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN t001eva.qtddia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t001eva.qtddia IS 'Quantidade de Dias Antes ou Após';


--
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN t001eva.stareg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t001eva.stareg IS 'Status do registro (A = Ativo; I = Inativo)';


--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN t001eva.conenv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t001eva.conenv IS 'Condição de Envio (0 = Antes do Vencimento;  1 = No Vencimento; 2 = Depois do Vencimento)';


--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN t001eva.horini; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t001eva.horini IS 'Horário Inicial';


--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN t001eva.horfin; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t001eva.horfin IS 'Horário Final';


--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN t001eva.envsbo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t001eva.envsbo IS 'Envia Somente Boleto';


--
-- TOC entry 221 (class 1259 OID 16400)
-- Name: t001eva_codeva_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t001eva_codeva_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t001eva_codeva_seq OWNER TO postgres;

--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 221
-- Name: t001eva_codeva_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t001eva_codeva_seq OWNED BY public.t001eva.codeva;


--
-- TOC entry 222 (class 1259 OID 16401)
-- Name: t030ema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t030ema (
    codema integer NOT NULL,
    srvstp character varying(50),
    srvprt character varying(30),
    emaend character varying(100),
    emasen character varying(100)
);


ALTER TABLE public.t030ema OWNER TO postgres;

--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE t030ema; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t030ema IS 'Cadastro de E-Mails';


--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN t030ema.codema; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t030ema.codema IS 'Código do E-Mail';


--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN t030ema.srvstp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t030ema.srvstp IS 'Servidor SMTP';


--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN t030ema.srvprt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t030ema.srvprt IS 'Porta do Servidor';


--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN t030ema.emaend; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t030ema.emaend IS 'E-Mail';


--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN t030ema.emasen; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t030ema.emasen IS 'E-Mail Senha';


--
-- TOC entry 223 (class 1259 OID 16404)
-- Name: t030ema_codema_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t030ema_codema_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t030ema_codema_seq OWNER TO postgres;

--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 223
-- Name: t030ema_codema_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t030ema_codema_seq OWNED BY public.t030ema.codema;


--
-- TOC entry 224 (class 1259 OID 16405)
-- Name: t070emp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t070emp (
    codemp integer NOT NULL,
    nomemp character varying(200) NOT NULL,
    apeemp character varying(200),
    cgccpf character varying(18),
    numtel character varying(14),
    numcel character varying(14),
    endcep character varying(10),
    endcid character varying(100),
    endufs character varying(2),
    endlog character varying(200),
    endnum character varying(30),
    endbai character varying(100),
    endcpl character varying(100),
    emaemp character varying(200),
    stareg character(1) DEFAULT 'A'::bpchar NOT NULL,
    chaemp integer
);


ALTER TABLE public.t070emp OWNER TO postgres;

--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE t070emp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t070emp IS 'Cadastro de empresas';


--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN t070emp.codemp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t070emp.codemp IS 'Código da Empresa';


--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN t070emp.nomemp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t070emp.nomemp IS 'Nome da Empresa';


--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN t070emp.stareg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t070emp.stareg IS 'Status do registro (A = Ativo; I = Inativo)';


--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN t070emp.chaemp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t070emp.chaemp IS 'Chave Empresa Ch Sistemas';


--
-- TOC entry 225 (class 1259 OID 16411)
-- Name: t070emp_codemp_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t070emp_codemp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.t070emp_codemp_seq OWNER TO postgres;

--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 225
-- Name: t070emp_codemp_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t070emp_codemp_seq OWNED BY public.t070emp.codemp;


--
-- TOC entry 226 (class 1259 OID 16412)
-- Name: t099usu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t099usu (
    codusu integer NOT NULL,
    nomusu character varying(50) NOT NULL,
    senusu character varying(100) NOT NULL,
    codpes integer NOT NULL,
    stareg character(1) NOT NULL
);


ALTER TABLE public.t099usu OWNER TO postgres;

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE t099usu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t099usu IS 'Cadastro de usuários';


--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN t099usu.codusu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t099usu.codusu IS 'Código do Usuário';


--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN t099usu.nomusu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t099usu.nomusu IS 'Nome do Usuário';


--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN t099usu.senusu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t099usu.senusu IS 'Senha do Usuário';


--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN t099usu.codpes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t099usu.codpes IS 'Código da Pessoa';


--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN t099usu.stareg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t099usu.stareg IS 'Status do registro (A = Ativo; I = Inativo)';


--
-- TOC entry 227 (class 1259 OID 16415)
-- Name: t099usu_codusu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t099usu_codusu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t099usu_codusu_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 227
-- Name: t099usu_codusu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t099usu_codusu_seq OWNED BY public.t099usu.codusu;


--
-- TOC entry 228 (class 1259 OID 16416)
-- Name: t100env; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t100env (
    codenv integer NOT NULL,
    datenv timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    codmsg integer NOT NULL,
    celdes character varying(50) NOT NULL,
    codtcr integer,
    codnfv integer,
    stamsg character varying(1) NOT NULL,
    tipenv character varying(1) NOT NULL,
    codusu integer,
    idemsg character varying(70),
    retenv character varying(2000),
    recres boolean,
    CONSTRAINT t100env_stamsg_check CHECK (((stamsg)::text = ANY (ARRAY[('A'::character varying)::text, ('P'::character varying)::text, ('E'::character varying)::text]))),
    CONSTRAINT t100env_tipenv_check CHECK (((tipenv)::text = ANY (ARRAY[('M'::character varying)::text, ('A'::character varying)::text])))
);


ALTER TABLE public.t100env OWNER TO postgres;

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE t100env; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t100env IS 'Mensagens Enviadas';


--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN t100env.codenv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100env.codenv IS 'Código do Envio da mensagem';


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN t100env.datenv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100env.datenv IS 'Data do Envio';


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN t100env.codmsg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100env.codmsg IS 'Código da Mensagem';


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN t100env.celdes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100env.celdes IS 'Número de celular do destinatário da mensagem';


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN t100env.codtcr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100env.codtcr IS 'Código do título a receber';


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN t100env.codnfv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100env.codnfv IS 'Código da Nota Fiscal';


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN t100env.stamsg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100env.stamsg IS 'Status da Mensagem (A = Aguardando; P = Processado; E = Erro)';


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN t100env.tipenv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100env.tipenv IS 'Tipo de Envio (M = Manual; A = Automático)';


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN t100env.codusu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100env.codusu IS 'Código do Usuário que fez o envio';


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN t100env.recres; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100env.recres IS 'Recebido Resposta';


--
-- TOC entry 229 (class 1259 OID 16422)
-- Name: t100env_codenv_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t100env_codenv_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t100env_codenv_seq OWNER TO postgres;

--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 229
-- Name: t100env_codenv_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t100env_codenv_seq OWNED BY public.t100env.codenv;


--
-- TOC entry 230 (class 1259 OID 16423)
-- Name: t100lis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t100lis (
    codmsg integer NOT NULL,
    codlis integer NOT NULL,
    opclis character varying(100) NOT NULL,
    codres integer NOT NULL
);


ALTER TABLE public.t100lis OWNER TO postgres;

--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE t100lis; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t100lis IS 'Cadastro de Mensagens - Opções Lista';


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN t100lis.codmsg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100lis.codmsg IS 'Código da Mensagem';


--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN t100lis.codlis; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100lis.codlis IS 'Código da Lista';


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN t100lis.opclis; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100lis.opclis IS 'Opção da lista';


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN t100lis.codres; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100lis.codres IS 'Código da resposta opção mensagem';


--
-- TOC entry 231 (class 1259 OID 16426)
-- Name: t100msg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t100msg (
    codmsg integer NOT NULL,
    desmsg character varying(50) NOT NULL,
    tipmsg integer NOT NULL,
    modmsg integer NOT NULL,
    txtmsg character varying(500) NOT NULL,
    txtbtn character varying(100),
    nomarq character varying(100),
    b64arq text,
    msgres character varying(500),
    CONSTRAINT t100msg_modmen_check CHECK ((modmsg = ANY (ARRAY[0, 1, 2, 3])))
);


ALTER TABLE public.t100msg OWNER TO postgres;

--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE t100msg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t100msg IS 'Cadastro de Mensagens - Dados Gerais';


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN t100msg.codmsg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100msg.codmsg IS 'Código da Mensagem';


--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN t100msg.desmsg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100msg.desmsg IS 'Descrição da mensagem';


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN t100msg.tipmsg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100msg.tipmsg IS 'Tipo da mensagem (0 - Financeira; 1 - Doc. Eletrônico; 2 = Boleto; 3 - Geral; 4 - Pós-venda; 5 - Marketing;)';


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN t100msg.modmsg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100msg.modmsg IS 'Modelo da mensagem (0 - Simples, 1 - Lista, 2 - Arquivo, 3 - Arquivo e lista)';


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN t100msg.txtmsg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100msg.txtmsg IS 'Texto da Mensagem';


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN t100msg.txtbtn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100msg.txtbtn IS 'Texto no Botão';


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN t100msg.nomarq; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100msg.nomarq IS 'Nome do Arquivo Para Mensagem Com Anexo';


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN t100msg.b64arq; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100msg.b64arq IS 'Arquivo Em Base64 Para Mensagem Com Anexo';


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN t100msg.msgres; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100msg.msgres IS 'Mensagem de Resposta quando nenhuma opção for selecionada na mensagem do tipo lista';


--
-- TOC entry 232 (class 1259 OID 16432)
-- Name: t100msg_codmsg_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t100msg_codmsg_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t100msg_codmsg_seq OWNER TO postgres;

--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 232
-- Name: t100msg_codmsg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t100msg_codmsg_seq OWNED BY public.t100msg.codmsg;


--
-- TOC entry 233 (class 1259 OID 16433)
-- Name: t100res; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t100res (
    codres integer NOT NULL,
    desres character varying(50) NOT NULL,
    tipres integer NOT NULL,
    msgres character varying(300),
    CONSTRAINT t100res_tipres_check CHECK ((tipres = ANY (ARRAY[0, 1, 2])))
);


ALTER TABLE public.t100res OWNER TO postgres;

--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE t100res; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t100res IS 'Cadastro de Mensagens - Resposta Opção Lista';


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN t100res.codres; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100res.codres IS 'Código da resposta opção lista';


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN t100res.desres; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100res.desres IS 'Descrição da opção da lista';


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN t100res.tipres; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100res.tipres IS 'Tipo de resposta (0 - Mensagem; 1 - Linha Digitável; 2 - Boleto PDF)';


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN t100res.msgres; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t100res.msgres IS 'Mensagem de resposta';


--
-- TOC entry 234 (class 1259 OID 16437)
-- Name: t100res_codres_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t100res_codres_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.t100res_codres_seq OWNER TO postgres;

--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 234
-- Name: t100res_codres_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t100res_codres_seq OWNED BY public.t100res.codres;


--
-- TOC entry 235 (class 1259 OID 16438)
-- Name: t140nfv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t140nfv (
    codnfv integer NOT NULL,
    orgreg character(1) NOT NULL,
    chareg integer,
    codemp integer NOT NULL,
    numnfv integer NOT NULL,
    datnfv timestamp without time zone NOT NULL,
    codpes integer NOT NULL,
    totnfv numeric(11,2) NOT NULL,
    stanfv character varying(20) NOT NULL,
    chanfe character varying(50),
    modnfe character varying(2),
    liknfs character varying(3000),
    CONSTRAINT orgreg_check CHECK (((orgreg)::text = ANY (ARRAY['M'::text, 'I'::text])))
);


ALTER TABLE public.t140nfv OWNER TO postgres;

--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE t140nfv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t140nfv IS 'Cadastro de notas fiscais de venda';


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.codnfv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.codnfv IS 'Código da Nota Fiscal';


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.orgreg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.orgreg IS 'Origem do registro (M = Manual; I = Importação)';


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.chareg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.chareg IS 'Chave do Registro Importado no Sistema de Origem';


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.codemp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.codemp IS 'Código da Empresa';


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.numnfv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.numnfv IS 'Número da Nota Fiscal';


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.datnfv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.datnfv IS 'Data da Nota Fiscal';


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.codpes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.codpes IS 'Código da Pessoa';


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.totnfv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.totnfv IS 'Total da Nota Fiscal';


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.stanfv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.stanfv IS 'Status da Nota Fiscal';


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.chanfe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.chanfe IS 'Chave de Acesso da Nota Fiscal';


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.modnfe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.modnfe IS 'Modelo da Nota Fiscal';


--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN t140nfv.liknfs; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t140nfv.liknfs IS 'Link NFSe';


--
-- TOC entry 236 (class 1259 OID 16442)
-- Name: t140nfv_codnfv_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t140nfv_codnfv_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t140nfv_codnfv_seq OWNER TO postgres;

--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 236
-- Name: t140nfv_codnfv_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t140nfv_codnfv_seq OWNED BY public.t140nfv.codnfv;


--
-- TOC entry 237 (class 1259 OID 16443)
-- Name: t201pes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t201pes (
    codpes integer NOT NULL,
    codemp integer,
    cadcli character(1) DEFAULT 'S'::bpchar NOT NULL,
    cadfor character(1) DEFAULT 'S'::bpchar NOT NULL,
    cadtra character(1) DEFAULT 'S'::bpchar NOT NULL,
    nompes character varying(200),
    apepes character varying(200),
    tippes character(1),
    cgccpf character varying(18),
    orgreg character(1),
    chareg integer,
    numtel character varying(50),
    numcel character varying(50),
    cadusu character(1) DEFAULT 'S'::bpchar NOT NULL,
    endcep character varying(10),
    endcid character varying(100),
    endufs character varying(2),
    endlog character varying(200),
    endnum character varying(30),
    endbai character varying(100),
    endcpl character varying(100),
    emapes character varying(200),
    stareg character(1),
    coderp character varying(20),
    CONSTRAINT t201pes_cadcli_check CHECK ((cadcli = ANY (ARRAY['S'::bpchar, 'N'::bpchar]))),
    CONSTRAINT t201pes_cadfor_check CHECK ((cadfor = ANY (ARRAY['S'::bpchar, 'N'::bpchar]))),
    CONSTRAINT t201pes_cadtra_check CHECK ((cadtra = ANY (ARRAY['S'::bpchar, 'N'::bpchar]))),
    CONSTRAINT t201pes_cadusu_check CHECK ((cadusu = ANY (ARRAY['S'::bpchar, 'N'::bpchar]))),
    CONSTRAINT t201pes_orgreg_check CHECK ((orgreg = ANY (ARRAY['M'::bpchar, 'A'::bpchar, 'I'::bpchar]))),
    CONSTRAINT t201pes_tipcli_check CHECK ((tippes = ANY (ARRAY['J'::bpchar, 'F'::bpchar])))
);


ALTER TABLE public.t201pes OWNER TO postgres;

--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE t201pes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t201pes IS 'Cadastro de pessoas';


--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.codpes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.codpes IS 'Código da Pessoa';


--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.codemp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.codemp IS 'Código da Empresa';


--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.cadcli; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.cadcli IS 'Cadastro de Cliente (S = Sim; N = Não)';


--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.cadfor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.cadfor IS 'Cadastro de Fornecedor (S = Sim; N = Não)';


--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.cadtra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.cadtra IS 'Cadastro de Transportador (S = Sim; N = Não)';


--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.nompes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.nompes IS 'Nome da Pessoa';


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.apepes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.apepes IS 'Nome Fantasia da Pessoa';


--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.tippes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.tippes IS 'Tipo de pessoa (J = Pessoa Jurídica; F = Pessoa Física)';


--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.cgccpf; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.cgccpf IS 'Número do CNPJ ou CPF';


--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.orgreg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.orgreg IS 'Origem do registro (M = Manual; I = Importação)';


--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.chareg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.chareg IS 'Chave do Registro Importado no Sistema de Origem';


--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.numtel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.numtel IS 'Número de Telefone';


--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.numcel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.numcel IS 'Número de Celular';


--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.cadusu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.cadusu IS 'Cadastro de Usuário (S = Sim; N = Não)';


--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.endcep; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.endcep IS 'CEP do Endereço';


--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.endcid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.endcid IS 'Cidade do Endereço';


--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.endufs; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.endufs IS 'Estado do Endereço';


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.endlog; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.endlog IS 'Logradouro do Endereço';


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.endnum; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.endnum IS 'Número do Endereço';


--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.endbai; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.endbai IS 'Bairro do Endereço';


--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.endcpl; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.endcpl IS 'Complemento do Endereço';


--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.emapes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.emapes IS 'E-Mail da Pessoa';


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.stareg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.stareg IS 'Status do registro (A = Ativo; I = Inativo)';


--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN t201pes.coderp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t201pes.coderp IS 'Código da Pessoa no sistema ERP';


--
-- TOC entry 238 (class 1259 OID 16458)
-- Name: t201pes_codpes_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t201pes_codpes_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t201pes_codpes_seq OWNER TO postgres;

--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 238
-- Name: t201pes_codpes_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t201pes_codpes_seq OWNED BY public.t201pes.codpes;


--
-- TOC entry 239 (class 1259 OID 16459)
-- Name: t301tcr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t301tcr (
    codtcr integer NOT NULL,
    codemp integer NOT NULL,
    numtit character varying(50) NOT NULL,
    sittit character(1) NOT NULL,
    datemi timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    codpes integer NOT NULL,
    obstcr character varying(250),
    vctori timestamp without time zone NOT NULL,
    vlrori numeric(11,2) NOT NULL,
    vctatu timestamp without time zone NOT NULL,
    vlrabe numeric(11,2) NOT NULL,
    vlrdsc numeric(11,2),
    datpgt timestamp without time zone,
    datger timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    orgreg character(1),
    chareg integer,
    nosnum character varying(20),
    codbar character varying(100),
    lindig character varying(100),
    numpar integer,
    totpar integer,
    urlpix character varying(500),
    CONSTRAINT orgreg_check CHECK ((orgreg = ANY (ARRAY['M'::bpchar, 'A'::bpchar, 'I'::bpchar]))),
    CONSTRAINT sittit_check CHECK ((sittit = ANY (ARRAY['A'::bpchar, 'C'::bpchar, 'L'::bpchar])))
);


ALTER TABLE public.t301tcr OWNER TO postgres;

--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE t301tcr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t301tcr IS 'Cadastro de títulos a receber';


--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.codtcr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.codtcr IS 'Código do títulos a receber';


--
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.codemp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.codemp IS 'Código da Empresa';


--
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.numtit; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.numtit IS 'Número do Título a Receber';


--
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.sittit; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.sittit IS 'Situação do título a receber (A = Aberto; C = Cancelado; L = Liquidado)';


--
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.datemi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.datemi IS 'Data e hora de emissão do título a receber';


--
-- TOC entry 5179 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.codpes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.codpes IS 'Código da Pessoa';


--
-- TOC entry 5180 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.obstcr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.obstcr IS 'Observação para o título';


--
-- TOC entry 5181 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.vctori; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.vctori IS 'Data e hora do vencimento original do título a receber';


--
-- TOC entry 5182 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.vlrori; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.vlrori IS 'Valor original do título a receber';


--
-- TOC entry 5183 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.vctatu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.vctatu IS 'Data e hora do vencimento atual do título';


--
-- TOC entry 5184 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.vlrabe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.vlrabe IS 'Valor em aberto do título';


--
-- TOC entry 5185 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.vlrdsc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.vlrdsc IS 'Valor do desconto a ser concedido ao título a receber';


--
-- TOC entry 5186 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.datpgt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.datpgt IS 'Data e hora do último pagamento do título a receber';


--
-- TOC entry 5187 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.datger; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.datger IS 'Data e hora da geração do registro';


--
-- TOC entry 5188 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.orgreg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.orgreg IS 'Origem do registro (M = Manual; I = Importação)';


--
-- TOC entry 5189 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.chareg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.chareg IS 'Chave do Registro Importado no Sistema de Origem';


--
-- TOC entry 5190 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.nosnum; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.nosnum IS 'Nosso Número';


--
-- TOC entry 5191 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.codbar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.codbar IS 'Código de Barras do Boleto';


--
-- TOC entry 5192 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.lindig; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.lindig IS 'Linha Digitável do Boleto';


--
-- TOC entry 5193 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.numpar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.numpar IS 'Número da Parcela';


--
-- TOC entry 5194 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN t301tcr.totpar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t301tcr.totpar IS 'Total de Parcelas';


--
-- TOC entry 240 (class 1259 OID 16468)
-- Name: t301tcr_codtcr_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t301tcr_codtcr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t301tcr_codtcr_seq OWNER TO postgres;

--
-- TOC entry 5195 (class 0 OID 0)
-- Dependencies: 240
-- Name: t301tcr_codtcr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t301tcr_codtcr_seq OWNED BY public.t301tcr.codtcr;


--
-- TOC entry 244 (class 1259 OID 27473)
-- Name: t710sen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t710sen (
    seqsen integer NOT NULL,
    codsen integer NOT NULL,
    stasen character(1),
    numcel character varying(50),
    CONSTRAINT t710sen_stasen_check CHECK ((stasen = ANY (ARRAY['A'::bpchar, 'P'::bpchar, 'E'::bpchar])))
);


ALTER TABLE public.t710sen OWNER TO postgres;

--
-- TOC entry 5196 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE t710sen; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t710sen IS 'Gestão de Senha SGA';


--
-- TOC entry 5197 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN t710sen.seqsen; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t710sen.seqsen IS 'Sequencial da senha';


--
-- TOC entry 5198 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN t710sen.codsen; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t710sen.codsen IS 'Código da Senha';


--
-- TOC entry 5199 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN t710sen.stasen; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t710sen.stasen IS 'Status da Senha (A = Aguardando Preparação; P = Pronto; E = Entregue)';


--
-- TOC entry 5200 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN t710sen.numcel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t710sen.numcel IS 'Número do Celular';


--
-- TOC entry 243 (class 1259 OID 27472)
-- Name: t710sen_seqsen_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t710sen_seqsen_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.t710sen_seqsen_seq OWNER TO postgres;

--
-- TOC entry 5201 (class 0 OID 0)
-- Dependencies: 243
-- Name: t710sen_seqsen_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t710sen_seqsen_seq OWNED BY public.t710sen.seqsen;


--
-- TOC entry 242 (class 1259 OID 26680)
-- Name: t999atz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t999atz (
    seqatz integer NOT NULL,
    nomscp character varying(255) NOT NULL,
    codver integer NOT NULL,
    datatz timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.t999atz OWNER TO postgres;

--
-- TOC entry 5202 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE t999atz; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t999atz IS 'Controle de Script atualização banco de dados';


--
-- TOC entry 5203 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN t999atz.seqatz; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t999atz.seqatz IS 'Sequencial de atualização';


--
-- TOC entry 5204 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN t999atz.nomscp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t999atz.nomscp IS 'Nome do Script';


--
-- TOC entry 5205 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN t999atz.codver; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t999atz.codver IS 'Código da Versão';


--
-- TOC entry 5206 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN t999atz.datatz; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t999atz.datatz IS 'Data da Atualização';


--
-- TOC entry 241 (class 1259 OID 26679)
-- Name: t999atz_seqatz_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t999atz_seqatz_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t999atz_seqatz_seq OWNER TO postgres;

--
-- TOC entry 5207 (class 0 OID 0)
-- Dependencies: 241
-- Name: t999atz_seqatz_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t999atz_seqatz_seq OWNED BY public.t999atz.seqatz;


--
-- TOC entry 245 (class 1259 OID 27714)
-- Name: t999mon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t999mon (
    chalin character varying(32) NOT NULL,
    verban integer,
    verpro character varying(20),
    vererp character varying(20),
    verwha character varying(20),
    verwsc character varying(20),
    verwsv character varying(20)
);


ALTER TABLE public.t999mon OWNER TO postgres;

--
-- TOC entry 5208 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN t999mon.chalin; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t999mon.chalin IS 'Chave de licença';


--
-- TOC entry 5209 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN t999mon.verban; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t999mon.verban IS 'Versão do Banco de Dados';


--
-- TOC entry 5210 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN t999mon.verpro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t999mon.verpro IS 'Versão do programa CRM';


--
-- TOC entry 5211 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN t999mon.vererp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t999mon.vererp IS 'Versão do Integrador ERP';


--
-- TOC entry 5212 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN t999mon.verwha; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t999mon.verwha IS 'Versão do Integrador WhatsApp';


--
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN t999mon.verwsc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t999mon.verwsc IS 'Versão do NPM WPPConnect Server Cli';


--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN t999mon.verwsv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t999mon.verwsv IS 'Versão do NPM WPPConnect Server';


--
-- TOC entry 4815 (class 2604 OID 26792)
-- Name: t000api codapi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t000api ALTER COLUMN codapi SET DEFAULT nextval('public.t000api_codapi_seq'::regclass);


--
-- TOC entry 4816 (class 2604 OID 26793)
-- Name: t001eva codeva; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t001eva ALTER COLUMN codeva SET DEFAULT nextval('public.t001eva_codeva_seq'::regclass);


--
-- TOC entry 4817 (class 2604 OID 26794)
-- Name: t030ema codema; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t030ema ALTER COLUMN codema SET DEFAULT nextval('public.t030ema_codema_seq'::regclass);


--
-- TOC entry 4818 (class 2604 OID 26795)
-- Name: t070emp codemp; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t070emp ALTER COLUMN codemp SET DEFAULT nextval('public.t070emp_codemp_seq'::regclass);


--
-- TOC entry 4820 (class 2604 OID 26796)
-- Name: t099usu codusu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t099usu ALTER COLUMN codusu SET DEFAULT nextval('public.t099usu_codusu_seq'::regclass);


--
-- TOC entry 4821 (class 2604 OID 26797)
-- Name: t100env codenv; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100env ALTER COLUMN codenv SET DEFAULT nextval('public.t100env_codenv_seq'::regclass);


--
-- TOC entry 4823 (class 2604 OID 26798)
-- Name: t100msg codmsg; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100msg ALTER COLUMN codmsg SET DEFAULT nextval('public.t100msg_codmsg_seq'::regclass);


--
-- TOC entry 4824 (class 2604 OID 26799)
-- Name: t100res codres; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100res ALTER COLUMN codres SET DEFAULT nextval('public.t100res_codres_seq'::regclass);


--
-- TOC entry 4825 (class 2604 OID 26800)
-- Name: t140nfv codnfv; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t140nfv ALTER COLUMN codnfv SET DEFAULT nextval('public.t140nfv_codnfv_seq'::regclass);


--
-- TOC entry 4826 (class 2604 OID 26801)
-- Name: t201pes codpes; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t201pes ALTER COLUMN codpes SET DEFAULT nextval('public.t201pes_codpes_seq'::regclass);


--
-- TOC entry 4831 (class 2604 OID 26802)
-- Name: t301tcr codtcr; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t301tcr ALTER COLUMN codtcr SET DEFAULT nextval('public.t301tcr_codtcr_seq'::regclass);


--
-- TOC entry 4836 (class 2604 OID 27476)
-- Name: t710sen seqsen; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t710sen ALTER COLUMN seqsen SET DEFAULT nextval('public.t710sen_seqsen_seq'::regclass);


--
-- TOC entry 4834 (class 2604 OID 26683)
-- Name: t999atz seqatz; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t999atz ALTER COLUMN seqatz SET DEFAULT nextval('public.t999atz_seqatz_seq'::regclass);


--
-- TOC entry 4858 (class 2606 OID 16484)
-- Name: t000emp pk_t000emp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t000emp
    ADD CONSTRAINT pk_t000emp PRIMARY KEY (codapi, codemp);


--
-- TOC entry 4856 (class 2606 OID 16486)
-- Name: t000api t000api_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t000api
    ADD CONSTRAINT t000api_pkey PRIMARY KEY (codapi);


--
-- TOC entry 4860 (class 2606 OID 16488)
-- Name: t001eva t000eva_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t001eva
    ADD CONSTRAINT t000eva_pkey PRIMARY KEY (codeva);


--
-- TOC entry 4862 (class 2606 OID 16490)
-- Name: t030ema t030ema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t030ema
    ADD CONSTRAINT t030ema_pkey PRIMARY KEY (codema);


--
-- TOC entry 4839 (class 2606 OID 16491)
-- Name: t070emp t070emp_cgccpf_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.t070emp
    ADD CONSTRAINT t070emp_cgccpf_check CHECK ((length((cgccpf)::text) = ANY (ARRAY[18, 14, 0]))) NOT VALID;


--
-- TOC entry 4864 (class 2606 OID 16493)
-- Name: t070emp t070emp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t070emp
    ADD CONSTRAINT t070emp_pkey PRIMARY KEY (codemp);


--
-- TOC entry 4840 (class 2606 OID 16494)
-- Name: t070emp t070emp_stareg_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.t070emp
    ADD CONSTRAINT t070emp_stareg_check CHECK ((stareg = ANY (ARRAY['A'::bpchar, 'I'::bpchar]))) NOT VALID;


--
-- TOC entry 4866 (class 2606 OID 16496)
-- Name: t099usu t099usu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t099usu
    ADD CONSTRAINT t099usu_pkey PRIMARY KEY (codusu);


--
-- TOC entry 4868 (class 2606 OID 16498)
-- Name: t100env t100env_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100env
    ADD CONSTRAINT t100env_pkey PRIMARY KEY (codenv);


--
-- TOC entry 4870 (class 2606 OID 16500)
-- Name: t100lis t100lis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100lis
    ADD CONSTRAINT t100lis_pkey PRIMARY KEY (codmsg, codlis);


--
-- TOC entry 4872 (class 2606 OID 16502)
-- Name: t100msg t100msg_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100msg
    ADD CONSTRAINT t100msg_pkey PRIMARY KEY (codmsg);


--
-- TOC entry 4874 (class 2606 OID 16504)
-- Name: t100res t100res_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100res
    ADD CONSTRAINT t100res_pkey PRIMARY KEY (codres);


--
-- TOC entry 4876 (class 2606 OID 16506)
-- Name: t140nfv t140nfv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t140nfv
    ADD CONSTRAINT t140nfv_pkey PRIMARY KEY (codnfv);


--
-- TOC entry 4878 (class 2606 OID 16509)
-- Name: t201pes t201pes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t201pes
    ADD CONSTRAINT t201pes_pkey PRIMARY KEY (codpes);


--
-- TOC entry 4880 (class 2606 OID 16511)
-- Name: t301tcr t301tcr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t301tcr
    ADD CONSTRAINT t301tcr_pkey PRIMARY KEY (codtcr);


--
-- TOC entry 4884 (class 2606 OID 27479)
-- Name: t710sen t710sen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t710sen
    ADD CONSTRAINT t710sen_pkey PRIMARY KEY (seqsen);


--
-- TOC entry 4882 (class 2606 OID 26686)
-- Name: t999atz t999atz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t999atz
    ADD CONSTRAINT t999atz_pkey PRIMARY KEY (seqatz);


--
-- TOC entry 4886 (class 2606 OID 27718)
-- Name: t999mon t999mon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t999mon
    ADD CONSTRAINT t999mon_pkey PRIMARY KEY (chalin);


--
-- TOC entry 4887 (class 2606 OID 16512)
-- Name: t000emp fk_codapi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t000emp
    ADD CONSTRAINT fk_codapi FOREIGN KEY (codapi) REFERENCES public.t000api(codapi);


--
-- TOC entry 4899 (class 2606 OID 16517)
-- Name: t201pes fk_codemp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t201pes
    ADD CONSTRAINT fk_codemp FOREIGN KEY (codemp) REFERENCES public.t070emp(codemp);


--
-- TOC entry 4900 (class 2606 OID 16522)
-- Name: t301tcr fk_codemp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t301tcr
    ADD CONSTRAINT fk_codemp FOREIGN KEY (codemp) REFERENCES public.t070emp(codemp);


--
-- TOC entry 4897 (class 2606 OID 16527)
-- Name: t140nfv fk_codemp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t140nfv
    ADD CONSTRAINT fk_codemp FOREIGN KEY (codemp) REFERENCES public.t070emp(codemp);


--
-- TOC entry 4888 (class 2606 OID 16532)
-- Name: t000emp fk_codemp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t000emp
    ADD CONSTRAINT fk_codemp FOREIGN KEY (codemp) REFERENCES public.t070emp(codemp);


--
-- TOC entry 4895 (class 2606 OID 16537)
-- Name: t100lis fk_codmsg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100lis
    ADD CONSTRAINT fk_codmsg FOREIGN KEY (codmsg) REFERENCES public.t100msg(codmsg);


--
-- TOC entry 4889 (class 2606 OID 16542)
-- Name: t001eva fk_codmsg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t001eva
    ADD CONSTRAINT fk_codmsg FOREIGN KEY (codmsg) REFERENCES public.t100msg(codmsg);


--
-- TOC entry 4890 (class 2606 OID 16547)
-- Name: t099usu fk_codpes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t099usu
    ADD CONSTRAINT fk_codpes FOREIGN KEY (codpes) REFERENCES public.t201pes(codpes);


--
-- TOC entry 4901 (class 2606 OID 16552)
-- Name: t301tcr fk_codpes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t301tcr
    ADD CONSTRAINT fk_codpes FOREIGN KEY (codpes) REFERENCES public.t201pes(codpes);


--
-- TOC entry 4898 (class 2606 OID 16557)
-- Name: t140nfv fk_codpes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t140nfv
    ADD CONSTRAINT fk_codpes FOREIGN KEY (codpes) REFERENCES public.t201pes(codpes);


--
-- TOC entry 4896 (class 2606 OID 16562)
-- Name: t100lis fk_codres; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100lis
    ADD CONSTRAINT fk_codres FOREIGN KEY (codres) REFERENCES public.t100res(codres);


--
-- TOC entry 4891 (class 2606 OID 16567)
-- Name: t100env t100env_codmsg_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100env
    ADD CONSTRAINT t100env_codmsg_fkey FOREIGN KEY (codmsg) REFERENCES public.t100msg(codmsg);


--
-- TOC entry 4892 (class 2606 OID 16572)
-- Name: t100env t100env_codnfv_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100env
    ADD CONSTRAINT t100env_codnfv_fkey FOREIGN KEY (codnfv) REFERENCES public.t140nfv(codnfv);


--
-- TOC entry 4893 (class 2606 OID 16577)
-- Name: t100env t100env_codtcr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100env
    ADD CONSTRAINT t100env_codtcr_fkey FOREIGN KEY (codtcr) REFERENCES public.t301tcr(codtcr);


--
-- TOC entry 4894 (class 2606 OID 16582)
-- Name: t100env t100env_codusu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t100env
    ADD CONSTRAINT t100env_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.t099usu(codusu);


-- Completed on 2024-11-18 17:38:24

--
-- PostgreSQL database dump complete
--

