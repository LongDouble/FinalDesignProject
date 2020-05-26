for file in *.do; do sed -i -e 's/a/signal/g' $file; done
for file in *.do; do sed -i -e 's/a/signal/g' $file; done
for file in *.do-e; do mv $file ${file%-e}; done

for file in *.do; do cat text.txt $file > $file-e; done
for file in *.do-e; do mv $file ${file%-e}; done
