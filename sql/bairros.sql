--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2015-11-29 13:42:03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 188 (class 1259 OID 17917)
-- Name: bairros; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bairros (
    id integer NOT NULL,
    nome character varying(255),
    poligono geometry(Polygon,4326)
);


ALTER TABLE bairros OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 17915)
-- Name: bairros_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE bairros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bairros_id_seq OWNER TO postgres;

--
-- TOC entry 3307 (class 0 OID 0)
-- Dependencies: 187
-- Name: bairros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE bairros_id_seq OWNED BY bairros.id;


--
-- TOC entry 3182 (class 2604 OID 17920)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bairros ALTER COLUMN id SET DEFAULT nextval('bairros_id_seq'::regclass);


--
-- TOC entry 3302 (class 0 OID 17917)
-- Dependencies: 188
-- Data for Name: bairros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bairros (id, nome, poligono) FROM stdin;
1	Centro	0103000020E61000000100000006000000EE290D550E493BC00000405B956B48C090C3575A91483BC00000405B656E48C000E31E71C3433BC00000401BA66D48C09D9A146F7B453BC0000040EB406C48C00073E76B43463BC00000401B036B48C0EE290D550E493BC00000405B956B48C0
2	Ribanceira	0103000020E610000001000000050000001BC32862BA473BC00000408BDE6A48C0F812BB706E433BC00000408B846A48C00B3E3B71F5433BC00000402BAF6348C033EA705D41483BC00000406B8D6348C01BC32862BA473BC00000408BDE6A48C0
3		0103000020E6100000010000001000000099CDA0D178EB3AC00000A045805448C03C4A640E83EA3AC00000A0E5B25448C01B6D4AE650EA3AC00000A0ED055448C05DA92D4C30EA3AC00000A0DD9D5348C085748DD982EB3AC00000A03D115348C0BB30874BB7EC3AC00000A01D145248C0B90BC95E1BEE3AC00000A0E53C5248C0F9EA4EC6A2EE3AC00000A0CDDB5248C0584F30E472EF3AC00000A02D5D5348C07039322D2AEF3AC00000A0DDCA5348C0674CB5E01DEE3AC00000A015A25348C07F555DFE9DED3AC00000A02D6B5448C062D0C4DD2AEC3AC00000A095125448C0912CA924E2EB3AC00000A0FD6D5448C0530D325490EB3AC00000B4F77D5448C099CDA0D178EB3AC00000A045805448C0
4	Fazenda	0103000020E6100000010000001000000099CDA0D178EB3AC00000A045805448C03C4A640E83EA3AC00000A0E5B25448C01B6D4AE650EA3AC00000A0ED055448C05DA92D4C30EA3AC00000A0DD9D5348C085748DD982EB3AC00000A03D115348C0BB30874BB7EC3AC00000A01D145248C0B90BC95E1BEE3AC00000A0E53C5248C0F9EA4EC6A2EE3AC00000A0CDDB5248C0584F30E472EF3AC00000A02D5D5348C07039322D2AEF3AC00000A0DDCA5348C0674CB5E01DEE3AC00000A015A25348C07F555DFE9DED3AC00000A02D6B5448C062D0C4DD2AEC3AC00000A095125448C0912CA924E2EB3AC00000A0FD6D5448C0530D325490EB3AC00000B4F77D5448C099CDA0D178EB3AC00000A045805448C0
5	Centro	0103000020E61000000100000008000000430F69ACA8EA3AC00000A02D985448C08347173C1CEA3AC00000A0759C5348C0BC3A3CC64EE83AC00000A0ADA05348C061249AD226E73AC00000A06D1C5448C00C975898E0E63AC00000A04D875448C01390D0F34EE73AC00000A065F65448C0DF56C70FE5E93AC00000A0EDE65448C0430F69ACA8EA3AC00000A02D985448C0
6	Ressacada	0103000020E6100000010000000600000017BE6D3E4BED3AC00000A0C50C5748C045F31BF78BEF3AC00000A03D955648C01B8233854DEE3AC00000A09DFA5448C0D5BD34657DED3AC00000A04D955548C02888F38EC6EB3AC00000A055F65548C017BE6D3E4BED3AC00000A0C50C5748C0
7	Dom Bosco	0103000020E610000001000000080000001A89C5D1B1EE3AC00000A0ED3D5848C0091585DB70ED3AC00000A045D75748C099CD47AA8CEC3AC00000A05D655748C07B1564E996EB3AC00000A0DDD55748C0430F69ACA8EA3AC00000A0FD6A5748C0D9D461887BEA3AC00000A0159F5648C0DC5F257FB2EB3AC00000A08DFA5548C01A89C5D1B1EE3AC00000A0ED3D5848C0
8	Sao Judas	0103000020E610000001000000060000000AA868A099EA3AC00000A005725748C0AD54FD2B08EA3AC00000A01DF25548C082E2795D08E93AC00000A06DB15548C0A3FE850601E83AC00000A005B05548C0D9BD25863AE93AC00000A0C5935748C00AA868A099EA3AC00000A005725748C0
9	Sao João	0103000020E610000001000000080000008A1595E30FE93AC00000A0CD9A5748C07ECEB7F0B0E63AC00000A04DDE5748C0CBC8FCB165E63AC00000A0558B5748C0E496A21AB1E53AC00000A015535748C002C1F1434AE53AC00000A01DF25548C06DD9314D86E63AC00000A04D955548C059D94EDDCEE73AC00000A0BD9D5548C08A1595E30FE93AC00000A0CD9A5748C0
10	Barra do Rio	0103000020E6100000010000000A0000009188F2B1DEE23AC00000A0A5F05648C0F722E4BBA9E43AC00000A0C5FE5548C002C1F1434AE53AC00000A0DD4E5748C011715D8468E43AC00000A005725748C0B59FDDB033E53AC00000A02DEF5748C02296773B40E53AC00000A0C51A5848C0FA2917AF9AE43AC00000A06DFA5748C07B788293BBE23AC00000A005EB5648C07B788293BBE23AC00000A005EB5648C09188F2B1DEE23AC00000A0A5F05648C0
11	Imarui	0103000020E6100000010000000A0000009229CE8AB1E23AC00000A025DA5648C0BE87ABF95BE43AC00000A0EDF45548C094C063BA7CE33AC00000A025455548C0EB017EEE90E23AC00000A025455548C0E2A0D2071BE23AC00000A05D765548C08FE335D3DEE13AC00000A08DCD5548C0428299D7E3E13AC00000A045155648C04012A28518E23AC00000A055505648C007CE44A43BE23AC00000A0D5935648C09229CE8AB1E23AC00000A025DA5648C0
12	São Vicente	0103000020E61000000100000012000000E291B8EB19E93AC00000A0E5AF5748C0250C5262ECEA3AC00000A09D9A5A48C0B3D76324C2E83AC00000A09D215B48C081A52782FCE43AC00000A04D385848C01E461F5963E53AC00000A0CD215848C09555A75059E53AC00000A0C5ED5748C0A8BC032222E53AC00000A0F5BD5748C0F722E4BBA9E43AC00000A085885748C0899B2471E8E43AC00000A0C5665748C01CCBF5F017E63AC00000A0656C5748C04BE25CBA6FE63AC00000A055B85748C06DD9314D86E63AC00000A055E55748C04F983DFDBFE63AC00000A0CDF45748C061249AD226E73AC00000A055E55748C03EE8788665E73AC00000A08DBC5748C09136FC1615E83AC00000A035F65748C0337F82FB8FE83AC00000A02DEF5748C0E291B8EB19E93AC00000A0E5AF5748C0
13	Cordeiros	0103000020E6100000010000000A00000029C20A9779E73AC00000A0AD7B5A48C0182D1CE640E03AC00000A03D465A48C0843F9F342AE13AC00000A0CD895948C0E760A27E5CE03AC00000A06D085948C0F558DC78E6E03AC00000A05DA05848C05C75710316E23AC00000A0ED975848C0965CD78A45E33AC00000A04D0B5848C0D2CD249C59E33AC00000A0356F5748C043063FE2D6E43AC00000A0E5365848C029C20A9779E73AC00000A0AD7B5A48C0
14	Murta	0103000020E61000000100000010000000E91C749070E03AC00000A06DF75A48C02F939AAF93E03AC00000A08DE65A48C0B48B53CB22E03AC00000A01D845A48C02F939AAF93E03AC00000A0552E5A48C0C278EE2216E13AC00000A0A5935948C075E226D3BBE03AC00000A0C5555948C009F6A5E13BE03AC00000A0D5365948C04BE1C50969E03AC00000A0FDD25848C09D910C48AFE03AC00000A01D955848C071EE813BF3DE3AC00000A0553F5848C0C1A3EBC3E1DD3AC00000A0E5905848C02B396A687DDD3AC00000A0750F5948C09730C50AA3DD3AC00000A045995948C0D5B6FEAE57DE3AC00000A09D405A48C0E8CF37370CE03AC00000A0D5CB5A48C0E91C749070E03AC00000A06DF75A48C0
15	Cabeçudas	0103000020E61000000100000007000000457A0A4CAAEE3AC00000A0C54D5248C0ABFB263094EC3AC00000A0D54D5148C0B66E359FC8ED3AC00000A055DD5048C0F7ECF08907ED3AC00000A0EDA04F48C01373C4297AF03AC00000A085535048C0454997BA90F03AC00000A05D1F5248C0457A0A4CAAEE3AC00000A0C54D5248C0
16	Praia Brava	0103000020E610000001000000050000006019525ABBF03AC00000A04D115248C0541A5EE7CCF03AC00000A0E54D5048C0E5B53481CBF53AC00000A0BD575048C01F6F44167EF43AC00000A0BDEC5148C06019525ABBF03AC00000A04D115248C0
17	Praia Brava	0103000020E6100000010000000700000013ED6DF1B4F53AC0000040FB5B5048C0E8BD45C778F53AC00000402BE05048C0176C720465F43AC00000408B075148C077E5930B6FF43AC00000402BEE5148C0898D6017BBF13AC00000406BF95148C0F1053B69CFF03AC0000040FB5B5048C013ED6DF1B4F53AC0000040FB5B5048C0
18	São Pedro	0103000020E61000000100000005000000030A9E6512E93AC00000402B485248C0B9BA60A526E83AC0000040EBF05248C067558B0868E73AC00000409B315348C0667BD41072E73AC00000409B505248C0030A9E6512E93AC00000402B485248C0
19	Centro	0103000020E610000001000000060000008EF01BFC58E73AC00000400B595248C0BAF7A7B908E73AC0000040DB695348C03219B14C27E43AC0000040EBDF5448C0D804305B0EE33AC00000404BDA5448C0EBFBD968B4DF3AC00000401BE05148C08EF01BFC58E73AC00000400B595248C0
20	São Domingos	0103000020E6100000010000000A000000F05741A9D4E23AC00000A05DEF5448C0EA4DA4A840E23AC00000A0953F5448C037B5082082E03AC00000405B805348C0695D81A8C3DD3AC00000401B185648C0D856038FFFE03AC00000403B6F5748C0387D420687E13AC00000406B3F5748C052B5D0EB68E13AC00000405B505648C04CC972FD7CE13AC00000409BA75548C04012A28518E23AC0000040BB3C5548C0F05741A9D4E23AC00000A05DEF5448C0
21	Machados	0103000020E6100000010000000C000000088869E181E23AC00000405B315748C039F824972CE23AC00000404B315848C03EDB772569DF3AC00000407B015848C07FF3BF2C3CDD3AC00000400B535848C0C8BDBDABAFDC3AC0000040AB665948C08F3F7B88A0DD3AC0000040CB635A48C0861B315841DB3AC0000040BBA15948C04EBE2C4F4BDC3AC00000404BD75748C0A21FB74355DD3AC00000406BE55648C0CD2ED0355FDE3AC00000408B7A5648C081148F6BD7E03AC0000040ABA45748C0088869E181E23AC00000405B315748C0
22	Porto das Balsas	0103000020E61000000100000007000000D38F39F06DE13AC00000400BF95748C0D4990AF977E13AC00000402B345748C07C4898CB68E23AC00000404B235748C0257A5511B9E23AC00000405BB85748C0CD9403AD45E23AC00000405B125848C0FBE856D14AE13AC00000404B045848C0D38F39F06DE13AC00000400BF95748C0
23	São Paulo	0103000020E610000001000000060000009F0AA04CD7E13AC00000405B8E5448C0590174B90EE03AC00000406B7D5548C094E3245A87DE3AC0000040DB2B5548C037B5082082E03AC00000404B455348C0AF20DE2DB4E13AC00000404B805448C09F0AA04CD7E13AC00000405B8E5448C0
\.


--
-- TOC entry 3308 (class 0 OID 0)
-- Dependencies: 187
-- Name: bairros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('bairros_id_seq', 23, true);


-- Completed on 2015-11-29 13:42:03

--
-- PostgreSQL database dump complete
--
