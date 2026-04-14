import streamlit as st
import pandas as pd
import duckdb

import seaborn as sns
import matplotlib.pyplot as plt

st.write("# Ettevõtluse statistika maakonniti")

data = pd.read_csv("emta_data.csv")

col1, col2 = st.columns(2)

with col1:
        aasta: str = st.selectbox("Aasta", options = sorted(data["aasta"].unique(), reverse = True))

with col2:
        kvartal: str = st.selectbox("Kvartal", options = duckdb.sql(f"SELECT DISTINCT kvartal FROM data WHERE aasta = {aasta} ORDER BY kvartal DESC"))

count_by_county = duckdb.sql(f"""
    SELECT 
        maakond, 
        count(DISTINCT registrikood) AS ettevotete_arv
    FROM data
    WHERE kvartal = {kvartal}
    AND aasta = {aasta}
    AND maakond NOT NULL
    GROUP BY maakond
    ORDER BY ettevotete_arv DESC;                     
""").df()

st.write("#### Tegutsevate ettevõtete arv maakonniti - streamlit")
st.bar_chart(count_by_county, y = "ettevotete_arv", x = "maakond", sort = False)

fig = plt.figure(figsize = (10, 4))
ax = sns.barplot(count_by_county, y = "ettevotete_arv", x = "maakond")
ax.set_title("Tegutsevate ettevõtete arv maakonniti - matplotlib")
st.pyplot(fig)



maakond: str = st.selectbox("Maakond", options=data["maakond"].unique())

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
