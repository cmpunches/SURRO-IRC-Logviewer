<?php
function getUsers()
{
	$unfilteredUserList		= scandir( $GLOBALS['log_root'] );
	$unsortedUserList		= array_diff( $unfilteredUserList, array( '..', '.' ) );
	$userList				= array_values( $unsortedUserList );
	return $userList;
}

function getNetworksForUser( $user )
{
	$unfilteredNetworkList 	= scandir( $GLOBALS['log_root'] . '/' . $user );
	$unsortedNetworkList 	= array_diff( $unfilteredNetworkList , array( '..', '.' ) );
	$networkList 			= array_values( $unsortedNetworkList );
	return $networkList;
}

function getChannelsForNetworkForUser( $user, $network )
{
	$unfilteredChannelList 	= scandir( $GLOBALS['log_root'] . '/' . $user . '/' . $network );
	$unsortedChannelList    = array_diff( $unfilteredChannelList, array( '..', '.' ) );
	$channelList 			= array_values( $unsortedChannelList );
	return $channelList;
}

function getLogs( $user, $network, $channel )
{
	$unfilteredLogList 		= scandir( $GLOBALS['log_root'] . '/' . $user . '/' . $network . '/' . $channel );
	$unsortedLogList 		= array_diff( $unfilteredLogList, array( '..', '.' ) );
	$logList			= array_values( $unsortedLogList );
	return $logList;
}

function getRawLog( $user, $network, $channel, $log )
{
	$logfilepath = $GLOBALS['log_root'] . '/' . $user . '/' . $network . '/' . $channel . '/' . $log;
	if ( file_exists($logfilepath) && is_file( $logfilepath )  )
	{
		$contents = file_get_contents($logfilepath);
		echo(htmlspecialchars($contents));
	} else {
		echo("Log either doesn't exist or isn't a file:  $logfilepath");
	}
}

function getPrettyLog( $user, $network, $channel, $log )
{
	$logfilepath = $GLOBALS['log_root'] . '/' . $user . '/' . $network . '/' . $channel . '/' . $log;
	if ( file_exists($logfilepath) && is_file( $logfilepath )  )
	{
		$contents = file($logfilepath);
		echo("<div class=\"ircLogDump\" id=\"ircLogDump\">");
		foreach( $contents as $entry )
		{
			echo("<p class=\"IRCEntry\" id=\"IRCEntry\">" . htmlspecialchars($entry) . "</p>");
		}
		echo("</div>");

	} else {
		echo("Log either doesn't exist or isn't a file:  $logfilepath");
	}
}


?>
