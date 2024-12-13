#!/usr/bin/env python
################################################################################
#        commbase-genai-slm-ollama-phi3-mini-memory-remote-rag-pinecone        #
#                                                                              #
# A sophisticated AI assistant's Small Language Model (Phi3), enhanced by      #
# Retrieval-Augmented Generation (RAG) for improved response accuracy, and     #
# supported by a Pinecone semantic vector database.                            #
#                                                                              #
# Change History                                                               #
# 06/25/2024  Esteban Herrera Original code.                                   #
#                           Add new history entries as needed.                 #
#                                                                              #
#                                                                              #
################################################################################
################################################################################
################################################################################
#                                                                              #
#  Copyright (c) 2022-present Esteban Herrera C.                               #
#  stv.herrera@gmail.com                                                       #
#                                                                              #
#  This program is free software; you can redistribute it and/or modify        #
#  it under the terms of the GNU General Public License as published by        #
#  the Free Software Foundation; either version 3 of the License, or           #
#  (at your option) any later version.                                         #
#                                                                              #
#  This program is distributed in the hope that it will be useful,             #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of              #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
#  GNU General Public License for more details.                                #
#                                                                              #
#  You should have received a copy of the GNU General Public License           #
#  along with this program; if not, write to the Free Software                 #
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   #

# load_a_dataset_with_pandas.py
# Uses Wikipedia articles from the SQuAD dataset (squad_dataset.csv)

# Imports
import pandas as pd

df = pd.read_csv('chat_log_dataset.csv')

# Print the top 10 rows (or all rows if there are less than 10)
print(df.head(10))

# Get the total number of rows
total_rows = len(df)

# Print the total number of rows
print(f"Total rows in the DataFrame: {total_rows}")