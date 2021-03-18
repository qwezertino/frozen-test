<?php

use Model\Boosterpack_model;
use Model\Login_model;
use Model\Post_model;
use Model\User_model;
use Model\UserPackLog_model;

/**
 * Created by PhpStorm.
 * User: mr.incognito
 * Date: 10.11.2018
 * Time: 21:36
 */
class Main_page extends MY_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->database();
        if (is_prod()) {
            die('In production it will be hard to debug! Run as development environment!');
        }
    }

    public function index()
    {
        $user = User_model::get_user();
        App::get_ci()->load->view('main_page', ['user' => User_model::preparation($user, 'default')]);
    }

    public function get_all_posts()
    {
        $posts = Post_model::preparation(Post_model::get_all(), 'main_page');
        return $this->response_success(['posts' => $posts]);
    }

    public function get_post($post_id)
    { // or can be $this->input->post('news_id') , but better for GET REQUEST USE THIS

        $post_id = intval($post_id);

        if (empty($post_id)) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }

        try {
            $post = new Post_model($post_id);
        } catch (EmeraldModelNoDataException $ex) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
        }


        $posts = Post_model::preparation($post, 'full_info');
        return $this->response_success(['post' => $posts]);
    }


    public function comment() //$post_id,$message
    { // or can be App::get_ci()->input->post('news_id') , but better for GET REQUEST USE THIS ( tests )

        $post_id = 1;
        $message = 'test1243';

        if (!User_model::is_logged()) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }

        $post_id = intval($post_id);

        if (empty($post_id) || empty($message)) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }

        try {
            $post = new Post_model($post_id);
        } catch (EmeraldModelNoDataException $ex) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
        }

        // Todo: 2 nd task Comment
        $post->comment($message);

        $posts = Post_model::preparation($post, 'full_info');
        return $this->response_success(['post' => $posts]);
    }


    public function login()
    {
        // Right now for tests we use from contriller
        $login = 'admin@niceadminmail.pl'; //App::get_ci()->input->post('login');
        $password = '123'; //App::get_ci()->input->post('password');

        if (empty($login) || empty($password)) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }

        $user_id = $this->db->get_where('user', ['email' => $login])->row('id');

        if (!$user_id) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_ACCESS);
        }
        $user = new User_model($user_id);

        Login_model::start_session($user);

        return $this->response_success(['user' => $user->get_id()]);
    }


    public function logout()
    {
        Login_model::logout();
        redirect(site_url('/', 'http'));
    }

    public function add_money()
    {

        if (!User_model::is_logged()) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }
        $money_amount = rand(1, 25);

        $user = User_model::get_user();

        try {
            $amount = $user->wallet_add($money_amount);
        } catch (Exception $e) {

            return $this->response_error($e->getMessage());
        }
        return $this->response_success(['amount' => $amount]);
    }

    public function buy_boosterpack()
    {
        if (!User_model::is_logged()) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }

        $user = User_model::get_user();

        $pack_id = rand(1,3);

        $pack = new Boosterpack_model($pack_id);

        $price = $pack->get_price();
        $bank = $pack->get_bank();

        try {
            $amount_withdraw = $user->wallet_withdraw($price);

        } catch (Exception $e) {

            return $this->response_error($e->getMessage());
        }

        $rnd_count = $price + $bank;
        $likes_result = rand(1, $rnd_count);

        $user->like_add($likes_result);

        $pack->set_bank($price - $likes_result);

        UserPackLog_model::create(['user_id' => $user->get_id(), 'pack_id' => $pack_id, 'likes' => $likes_result]);

        return $this->response_success(['amount_withdraw' => $amount_withdraw, 'pack_price' => $price, 'likes' => $likes_result]);
    }


    public function like() //$post_id
    {
        if (!User_model::is_logged()) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }
        $user = User_model::get_user();

        try {
            $user->like_withdraw();
        } catch (Exception $e) {
            return $this->response_error($e->getMessage());
        }

        $post_id = 1;
        $post = new Post_model($post_id);
        $post->add_like();
        return $this->response_success(['likes' => $post->get_likes()]);
    }

}
