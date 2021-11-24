perl /usr/local/bin/postprocessor_ur2hi/printinput.pl $1 > /var/www/html/indic-trans-0.1/scripts/uploads/tmp.txt
python3 /usr/local/bin/postprocessor_ur2hi/post_processor.py -l=/usr/local/bin/postprocessor_ur2hi/list.txt -i=/var/www/html/indic-trans-0.1/scripts/uploads/tmp.txt -o=/var/www/html/indic-trans-0.1/scripts/uploads/out.txt

