import React from "react";
import {Modal, ModalHeader, ModalBody, Button} from "reactstrap";
import { Link } from "react-router-dom";

class MyPosts extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            posts: [],
            isCommentOpen: false,
            selectedPost: '',
            selectedComments: []
        }
        this.handleChangeSelected = this.handleChangeSelected.bind(this);
        this.toggleComment = this.toggleComment.bind(this);
    }

    componentDidMount() {
        // if(localStorage.getItem('token')!=null){
        if (this.props.login) {
            const url = this.props.cur ? "/api/v1/posts/cur_posts" : "/api/v1/posts/pre_posts";
            fetch(url)
                .then(response => {
                    if (response.ok) {
                        return response.json();
                    }
                    throw new Error("Network response was not ok.");
                })
                .then(response => this.setState({ posts: response }))
                .catch(() => this.props.history.push("/"));
        } else {
            alert("Please login or sign up first!");
        }
    }

    handleChangeSelected(postID) {
        this.setState({selectedPost: postID}, function () {
            this.toggleComment()
        });
    }

    toggleComment() {
        const selected_post = this.state.posts.filter((post) => post.id === this.state.selectedPost)[0];
        this.setState({
            selectedComments: selected_post.comments,
            isCommentOpen: !this.state.isCommentOpen
        });
    }

    render() {
        const posts = this.state.posts.map((post) => {
            return (
                <div key={post.id} className="col-12 col-md-8 offset-md-1" style={{
                    marginBottom: "30px",
                    borderStyle: "outset",
                    borderRadius: "10px",
                    borderWidth: "1px",
                    borderColor: "rgba(224,224,224,0.3)"
                }}>
                    <div className="col-12 col-md-6 offset-md-3" style={{marginTop: "40px"}}>
                        <p><strong>Title:</strong> {post.title}</p>
                    </div>
                    <div className="col-12 col-md-6 offset-md-3">
                        <p><strong>Location:</strong> {post.location}</p>
                    </div>
                    <div className="col-12 col-md-6 offset-md-3">
                        <p><strong>Start Time:</strong> {post.startTime}</p>
                    </div>
                    <div className="col-12 col-md-6 offset-md-3">
                        <p><strong>End Time:</strong> {post.endTime}</p>
                    </div>
                    <div className="col-12 col-md-6 offset-md-3">
                        <p><strong>Credit:</strong> {post.credit}</p>
                    </div>
                    <div className="col-12 col-md-6 offset-md-3">
                        <p><strong>Request:</strong> {post.taskDetails}</p>
                    </div>
                    <div className="col-12 col-md-6 offset-md-3">
                        <p><strong>helperEmail:</strong> {post.helperEmail}</p>
                    </div>
                    <div className="row">
                        {/*<div className="col-6 col-md-2 offset-md-5" style={{*/}
                        {/*    fontSize: "13px",*/}
                        {/*    height: "40px",*/}
                        {/*    paddingTop: "16px",*/}
                        {/*    paddingRight: "0px",*/}
                        {/*    marginRight: "0px",*/}
                        {/*    marginBottom: "20px"*/}
                        {/*}}>*/}
                        {/*    <center>*/}
                        {/*        <strong>*/}
                        {/*            <Link onClick={() => this.handleChangeSelected(post.id)}>*/}
                        {/*                <i className="fa fa-chevron-circle-down" aria-hidden="true" style={{color: "rgba(0, 51, 160, 1)"}}/>*/}
                        {/*                Show Comment(s)*/}
                        {/*            </Link>*/}
                        {/*        </strong>*/}
                        {/*    </center>*/}
                        {/*</div>*/}
                        {this.props.cur && (
                            // <div className="col-6 col-md-4" style={{
                            //     height: "40px",
                            //     paddingTop: "8px",
                            //     paddingLeft: "0px",
                            //     marginLeft: "0px",
                            //     marginBottom: "20px"
                            // }}>
                                <center>
                                    <strong>
                                        <Button
                                            color="primary"
                                            onClick={() => this.props.history.push(`/edit/${post.id}`)}
                                            style={{
                                                color: '#FFF',
                                                minWidth: 100,
                                                maxWidth: 100
                                            }}>
                                            Edit
                                        </Button>
                                    </strong>
                                </center>
                            // </div>
                        )}
                    </div>
                </div>
            );
        });

        const comment = this.state.selectedComments.map((comment) => {
            return (
                <div style={{
                    marginBottom: "30px",
                    borderStyle: "outset",
                    borderRadius: "10px",
                    borderWidth: "1px",
                    borderColor: "rgba(224,224,224,0.3)"
                }}>
                    <div className="col-12 col-md-6 offset-md-3" style={{marginTop: "20px"}}>
                        <p><strong>Commentor:</strong> {comment.commentor}</p>
                    </div>
                    <div className="col-12 col-md-6 offset-md-3">
                        <p><strong>Commentee:</strong> {comment.commentee}</p>
                    </div>
                    <div className="col-12 col-md-6 offset-md-3">
                        <p><strong>Comment:</strong> {comment.content}</p>
                    </div>
                </div>
            );
        });

        return (
            <>
                <div className="container">
                    <div className="col-12" style={{marginTop: "100px"}}>
                        <div className="row">
                            <div className="col-12 col-md-6">
                                <h5 style={{fontFamily: "Arial Black", display: "inline"}}>{this.props.cur ? "Current Requests" : "Requests Completed"}</h5>
                            </div>
                        </div>
                        <hr className="seperation"/>
                    </div>
                    <div className="col-12" style={{marginTop: "50px"}}>
                        <div className="row">
                            {posts}
                        </div>
                    </div>
                </div>
                {/*<Modal isOpen={this.state.isCommentOpen} toggle={this.toggleComment}>*/}
                {/*    <ModalHeader toggle={this.toggleComment}>Comment(s)</ModalHeader>*/}
                {/*    <ModalBody style={{marginTop: "20px"}}>{comment}</ModalBody>*/}
                {/*</Modal>*/}
            </>
        );
    }
}

export default MyPosts;