<?php

namespace Model;
use App;
use CI_Emerald_Model;

class UserPackLog_model extends CI_Emerald_Model {

    const CLASS_TABLE = 'user_pack_log';

    /** @var integer */
    protected $user_id;
    /** @var integer */
    protected $pack_id;
    /** @var integer */
    protected $likes;
    /** @var string */
    protected $time_created;

    function __construct($id = NULL)
    {
        parent::__construct();
        $this->set_id($id);
    }

    public static function create(array $data)
    {
        App::get_ci()->s->from(self::CLASS_TABLE)->insert($data)->execute();
        return new static(App::get_ci()->s->get_insert_id());
    }
}
