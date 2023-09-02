<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'imurugar' );

/** MySQL database password */
define( 'DB_PASSWORD', '123123' );

/** MySQL hostname */
define( 'DB_HOST', 'mariadb' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'D+,nh!Hl@Ud2Y+9N9wUA; =5z6xO,}!E%Y2H|2|a6uO;)sRz=4KGwe)ugSq5;zdx');
define('SECURE_AUTH_KEY',  'm-t^o5<&h6(6A:4@va%?WREw_E]dxb.-:sz~&@}xx7g.al0Kgi>:|^c]uTbra{Fx');
define('LOGGED_IN_KEY',    '/HrXT5>0cTJDJW<h|xH3lr3L1+_D?CG1e|&IlycZ[-+/QM/oy@cNaEEC3a+IR246');
define('NONCE_KEY',        ',-oJdO1-~+g5d-O+5O;N:tw8em-&t`G8<#5Q#fJ<)/ciuQ5_m1qoiSNmXa8L+i7E');
define('AUTH_SALT',        '&!5XOC1bczgodmvZ2@I!/(f<r7zDO-,bJ3| o9L-T!%]GzsrAA$PG|Y`>88K9-CX');
define('SECURE_AUTH_SALT', 'ty0Y+/R60v(1#Q*,^yfxG:bC|N[N1- r)1un;-ZQ}.r3p&;Ns[|4n ()2:2z5rw/');
define('LOGGED_IN_SALT',   'DS+fO+I(bnSq+=nqKkqY@.6|.sDy(z26@5%V^]*GUQKP--MMSHLH)P|$la?6^n|K');
define('NONCE_SALT',       'CSS/@lqHV5Gt$-HQ(#6tm9`:Xdu4xD;9O<i}>H|<%Qu!KDzlLC|sZ{`~+>)!CYp>');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

 /* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';