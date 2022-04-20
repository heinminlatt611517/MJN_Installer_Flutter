const app_version = '1.0';

// staging url
const BASE_URL = 'http://mojoenet.myanmaronlinecreations.com/';

// live url
//

//Get page name
const LOGIN = '/login';
const TICKET_STATUS_PAGE = '/ticket_status';
const CUSTOMER_STATUS_PAGE = '/customer_status';
const HOME = '/home';
const CUSTOMER_DETAIL_PAGE = '/customer_detail';
const CUSTOMER_ISSUE_PAGE = '/customer_issue';
const PENDING_CUSTOMER_COMPLETE_PAGE = '/pending_complete_customer';
const COMPLETE_CUSTOMER_PAGE = '/complete_complete_list';
const COMPLETE_CUSTOMER_DETAIL_PAGE = '/complete_complete_detail_page';
const MY_APP = '/my_app';
const NEW_ORDER_CUSTOMER_PAGE = '/new_order_customer_page';
const MY_LOCATION_PAGE = '/my_location_page';


const INSTALLATION = 'installation';
const SERVICE_TICKET = 'service_ticket';
const PENDING = 'Pending';
const COMPLETE = 'Complete';
const NEW_ORDER = 'New Order';
const ORDER_ACCEPTED = 'Order Accepted';

//app_version
const APP_VERSION = '&app_version=';

//page argument
const PAGE_ARGUMENT = '';

//get storage key
const TOKEN = 'token';
const SAVE_TIME = 'save_time';
const UID = 'uid';
const ALL_DROP_DOWN_LISTS = 'all_drop_down_lists';


// param api
const UID_PARAM = '&uid=';
const TYPE_PARAM = 'type=';
const STATUS_PARAM = '&status=';
const PROFILE_ID_PARAM = '&profile_id=';
const TICKET_ID_PARAM = '&ticket_id=';
const TOWNSHIP_PARAM = '&township=';
const ASSIGNED_DATE_PARAM = '&assigned_date=';
const USERNAME_PARAM = '&username=';
const FILTER_STATUS = '&filter_status=';

const API_URL = BASE_URL+'api/';
const SUPPORT_LOGIN_URL = API_URL+"support_login";
const LATITUDE_LONGITUDE_URL = API_URL+"hit_support_lat_lon";
const ALL_DDL_DATA = API_URL+"get_all_ddl_data";
const SERVICE_TICKET_LIST_URL = API_URL+"get_service_tickets_lists_by_uid?";
const INSTALLATION_LIST_URL = API_URL+"get_installation_lists_by_uid?";
const GET_INSTALLATION_DETAIL_URL = API_URL+"get_installation_details?";
const GET_SERVICE_TICKET_DETAIL_URL = API_URL+"get_service_tickets_details?";
const POST_INSTALLATION_DATA_URL = API_URL+"post_installation_data";
const POST_SERVICE_TICKET_DATA_URL = API_URL+"post_service_tickets_data";
const GET_ALL_COUNT_URL = API_URL+"get_counts?";
const SERVICE_TICKET_ORDER_ACCEPT_URL = API_URL+"order_accept";
const INSTALLATION_ORDER_ACCEPT_URL = API_URL+"installation_order_accept";
const GET_INSTALLATION_USAGES_URL = API_URL+"get_usages?";
const POST_INSTALLER_LAT_LONG_URL = API_URL+"post_installer_lat_long";
const SEND_SMS_BRIX_URL = API_URL+"send_sms_brix";

