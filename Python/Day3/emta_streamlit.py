import streamlit as st
import pandas as pd
import duckdb

st.write("# Ettevõtluse statistika maakonniti")

data = pd.read_csv("emta_data.csv")

maakond = st.selectbox("Maakond", options=data["maakond"].unique())

st.write(duckdb.sql(f"""
    SELECT
        kov,
        count(registrikood) AS ettevotete_arv,
        ROUND(AVG(kaive), 0)::int AS keskmine_kvartaalne_kaive,
        ROUND(AVG(kaive/3), 0)::int AS keskmine_kuine_kaive
    FROM data
    WHERE aasta = 2026 AND kvartal = 1 AND maakond = '{maakond}'
    GROUP BY kov
    ORDER BY keskmine_kvartaalne_kaive DESC;
""").df()
)