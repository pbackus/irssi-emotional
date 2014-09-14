use strict;
use warnings;
use English '-no_match_vars';
use Irssi;

our $VERSION = '0.1.0';
our %IRSSI = (
	authors     => 'Paul Backus',
	contact     => 'snarwin@gmail.com',
	name        => 'emotional',
	description => 'Provides shortcuts for unicode emotes',
	license     => 'MIT',
	url         => 'https://github.com/pbackus/irssi-emotional',
);

my %emotes = (
	'dongers' => 'ヽ༼ຈل͜ຈ༽ﾉ',
	'flip'    => '(╯°□°）╯︵ ┻━┻',
	'lenny'   => '( ͡° ͜ʖ ͡°)',
	'look'    => 'ಠ_ಠ',
	'shades'  => '(-■_■)',
	'shrug'   => '¯\_(ツ)_/¯',
	'tears'   => 'ಥ_ಥ',
	'unflip'  => '┬─┬ノ( º _ ºノ)',
);

sub render_emotes {
	my ($text, $server, $win_item) = @_;

	my ($name, $offset, $length);

	while ($text =~ /:(\w+):/g) {
		$name = $1;
		$offset = $LAST_MATCH_START[0];
		$length = $LAST_MATCH_END[0] - $offset;

		if (exists $emotes{$name}) {
			substr($text, $offset, $length) = $emotes{$name};
		}
	}

	Irssi::signal_continue($text, $server, $win_item);
}

Irssi::signal_add('send text', \&render_emotes);
