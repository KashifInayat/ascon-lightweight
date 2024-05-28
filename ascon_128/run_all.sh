
#   - Kashif Inayat - kashif.inayat@inu.ac.kr
#
# REVISION:
#   0.0.1 - Initial release. 2024-05-27


##Removing
node="32nm"
dir=("encrypt_1block_128"  "encrypt_2blocks_128"  "encrypt_3blocks_128"  "encrypt_6blocks_128"	"ascon_encrypt") 
for str in ${dir[@]}; do
 	cd ./$str
	rm -r input*
	rm -r pdk*
	rm -r scripts*
	rm -r *.py
	rm -r Make*
 	cd ../	
done

# ## Running all
# node="32nm"
# dir=("encrypt_1block_128"  "encrypt_2blocks_128"  "encrypt_3blocks_128"  "encrypt_6blocks_128"	"ascon_encrypt") 
# for str in ${dir[@]}; do
# 	cd ./$str
# 	mkdir work_dc
# 	python3 run_synthesis.py --pdk $node
# 	python3 run_power.py --pdk $node
# 	python3 collect_all.py  
# 	mkdir pdk$node
# 	mv work_dc ./pdk$node
# 	mv flis* ./pdk$node
# 	mv nflis* ./pdk$node
# 	mv synth*  ./pdk$node
# 	mv log_*  ./pdk$node
# 	rm -r work_*
# 	cd ../	
# done

##copying

# dir=("encrypt_1block_128"  "encrypt_2blocks_128"  "encrypt_3blocks_128"  "encrypt_6blocks_128")
# for str in ${dir[@]}; do
# 	#cp ./test/flist.f ./$str/
# 	#cp ./test/nflist.f ./$str/	
# 	#cp -r ./test/inputs ./$str/
# 	#cp -r ./test/scripts ./$str/
# done
