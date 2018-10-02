#!F:\Strawberry\perl\bin\perl -w

use Selenium::Remote::Driver;
use Test::WWW::Selenium;
use Test::More "no_plan";
use Test::Exception;

######################################################################
# CDom_ffox_10.t © Mark Eason 01/10/2018
# Usinig the Selenium testing api this script interogates "https://the-internet.herokuapp.com/challenging_dom"
# for the presence, location and attributes of the elements returned/not returned by the web page
#
######################################################################

#Input capabilities
my $extraCaps = {
  "browser" => "Firefox",
  "browser_version" => "62.0",
  "os" => "Windows",
  "os_version" => "10",
  "resolution" => "1024x768"
};


my $login = "headerhound1";
my $key = "33LEUNabSkEC9sS7FnJE";
my $host = "$login:$key\@hub-cloud.browserstack.com";
my $url = "https://the-internet.herokuapp.com/challenging_dom";

my $driver = new Selenium::Remote::Driver('remote_server_addr' => $host,
  'port' => '80', 'extra_capabilities' => $extraCaps);
# $driver->get('https://the-internet.herokuapp.com/challenging_dom');
$driver->get($url);
# $driver->find_element('q','name')->send_keys("BrowserStack");
# $driver->open_ok("/");
#  $driver->get_ok($url);

my $qtitle = $driver->get_title();
# is $ptitle eq 'The Internet';
# Test 1
my $ptitle = $driver->find_element('title', 'tag_name');
    is $ptitle->get_text, '';

	
print "Page title returned: $qtitle";
print "\n";
# Test 2
my $h3 = $driver->find_element('h3', 'tag_name');
    is $h3->get_text, 'Challenging DOM';

# Test 3  This croaks on finding nothing
my $csslnk = $driver->find_element_by_link("/css/app.css", 'link');
# my $csslnk = $driver->find_element('/css/app.css', 'link_text');
# print "Got $csslnk for find";
if($csslnk == 0) {is "", '';}

# Test 4
my $ptable;
eval{
$ptable = $driver->find_element('table', 'tag_name');
};
ok !$@, 'Found the table';
# is $ptable->get_text, 'Lorem';

# Test 5
my @jses = $driver->find_elements('large-2 columns', 'class');
    is scalar @jses, 0, 'Count of button class container';
	
# my $div = $driver->find_element('//div', 'xpath');
#    is $div->get_attribute('id'), 'links', 'links div';

# Test 6
my @prows = $driver->find_elements('row', 'class');
is scalar @prows, 5, 'Count of row div elements';

# Test 7
# my $srows3 = $driver->find_child_element($prows[2], 'large-12 columns large-centered', 'class');
my @srows1 = $driver->find_child_elements($prows[0], 'large-12 columns', 'class');
is scalar @srows1, 0, 'Count of sub elements in row 1';

# my @srows2 = $driver->find_child_elements($prows[1], 'https://github.com/tourdedave/the-internet', 'link');
# my @srows2 = $driver->find_child_elements($prows[1], './option[@link="https://github.com/tourdedave/the-internet"]');
# Test 8
my @srows2 = $driver->find_child_elements($prows[1], 'https://github.com/tourdedave/the-internet', 'link');
is scalar @srows2, 0, 'Count of links returned row 2';


# Test 9
my @srows3 = $driver->find_child_elements($prows[2], 'large-12 columns large-centered', 'class');
is scalar @srows3, 0, 'Count of sub elements in row 3';

# Test 10
my @button_1 = $driver->find_child_elements($prows[2], './option[@class="button"]');
	is scalar @button_1, 0, 'Count of sub elements of class button';
	


# Test 11
my @elems = $driver->find_elements('div', 'class');
    is scalar @elems, 0, 'Count of div';

# Test 12
my $xbutt = $driver->find_element_by_xpath('button', 'class');
if($xbutt == 0) {is "", '';}

my $pcanvas = $driver->find_element_by_tag_name('canvas');
if($pcanvas == 0) {is "", '';}

# Test 13
my $qcanvas;
    eval {
        $qcanvas = $driver->find_element('canvas', 'tag_name');
    };
    ok !$@, 'Found the canvas';
	
sleep("3");
# $driver->find_element("xpath=id('2c7b9830-a716-0136-eb36-0ac3e8429804')");

$driver->quit();

