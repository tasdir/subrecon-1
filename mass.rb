require 'socket'
require 'colorize'
begin
  puts"+-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+- +-+-+-+-+-+".red
  puts"|M|A|S|S| |S|U|B|D|O|M|A|I|N| |C|O|L|L|E|C|T| |B|Y |T|A|S|D|I|R|".red
  puts"+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+-+-+-+-+".green
  puts
   domain = ARGV[0]
rescue
   puts "Usage ruby mass.rb domain"
   exit
end
  puts
  puts "-===================|| SubDomains By Subfinder ||====================-"
  system("subfinder -d #{domain} -o subfinder_#{domain}.txt")
  puts
  puts "Collecting By Subfinder Done!"
  puts
  puts
# https://github.com/tomnomnom/assetfinder
  puts "-===================|| SubDomains By  Asset-finder ||====================-"
  system("assetfinder -subs-only #{domain} > assetfinder_#{domain}.txt")
  puts
  puts "Collecting By Asset-finder Done and Save As assetfinder_#{domain}.txt!"
  puts
  puts "-===================|| SubDomains By Crt.sh ||====================-"
  system("curl -s 'https://crt.sh/?q=%.#{domain}&output=json' | jq -r '.[].name_value' | sed 's/\*\.//g' |sort -u > crt_#{domain}.txt")
  puts
  puts "Collecting By Crt.sh done!"
  puts
  puts "-===================|| SubDomains By certspotter ||====================-"
  system("curl -s https://certspotter.com/api/v0/certs?domain=#{domain} | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep #{domain} > certspot_#{domain}.txt")
  puts
  puts "Collecting By CertSpotter Done!"
  puts "-===================|| SubDomains By ctfr ||====================-"
  system("python3 ctfr/ctfr.py --domain #{domain} -o ctfr_#{domain}.txt")
  puts
  puts "Collecting By ctfr Done!"
  puts
#https://github.com/rbsec/dnscan
#puts "-===================|| SubDomains By dnscan ||====================-"    #######all_data_mixed
#system("python3 dnscan/dnscan.py -d #{domain} --nocheck -o dnscan_#{domain}.txt")
#puts
#puts "Collecting By dnscan Done!"
  puts
#https://github.com/Edu4rdSHL/findomain
  puts "-===================|| SubDomains By Findomain ||====================-"
  system("findomain -t #{domain} -u findomain_#{domain}.txt")
  puts
  puts "Collecting By Findomain Done!"
  puts
  puts "-===================|| SubDomains By SubDomainizer ||====================-"
  system("python3 SubDomainizer/SubDomainizer.py -u #{domain} -o SubDomainizer_#{domain}.txt")
  puts
  puts "Collecting By SubDomainizer Done!"
  puts
#https://github.com/gwen001/github-search
#http://10degres.net/github-tools-collection/
  puts "-===================|| SubDomains By Github ||====================-"
  system("python3 github-search/github-subdomains.py -t ******your_github_token****  -d #{domain} > githubsearch_#{domain}.txt")
  puts
  puts "Collecting By Github-Subdomain Done!"
  puts
  puts "-===================|| SubDomains By Sublist3r ||====================-"
  system("sublist3r -d #{domain} -o sublist3r_#{domain}.txt ")
  puts
  puts "Collecting By Sublist3r Done!"
  puts
 #https://github.com/OWASP/Amass/blob/master/examples/config.ini
  puts "-===================|| SubDomains By Amass ||====================-"
  system("amass enum -passive -d #{domain} > amass_#{domain}.txt")
  puts
  puts "Collecting By Amass Done!"
  system("chaos -d #{domain} -silent -o chaos_#{domain}.txt")
  system("cat chaos_#{domain}.txt amass_#{domain}.txt assetfinder_#{domain}.txt SubDomainizer_#{domain}.txt ctfr_#{domain}.txt githubsearch_#{domain}.txt certspot_#{domain}.txt crt_#{domain}.txt findomain_#{domain}.txt subfinder_#{domain}.txt sublist3r_#{domain}.txt > #{domain}.txt ")
  system("rm chaos_#{domain}.txt amass_#{domain}.txt assetfinder_#{domain}.txt SubDomainizer_#{domain}.txt ctfr_#{domain}.txt githubsearch_#{domain}.txt certspot_#{domain}.txt crt_#{domain}.txt findomain_#{domain}.txt subfinder_#{domain}.txt sublist3r_#{domain}.txt ")

