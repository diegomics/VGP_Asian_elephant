source bionano.cnf

mkdir -p "${OUT_DIR}/${ASSEMBLY_NAME}"
cd "${OUT_DIR}/${ASSEMBLY_NAME}"
cp "${BIONANO_DIR}/*hybrid*" .
ln -s $ASSEMBLY "${ASSEMBLY_NAME}.fasta"
ln -s $CMAP "DL1.cmap"

bash submit_hybrid_scaffold_dle1_3.3.sh $NAME
