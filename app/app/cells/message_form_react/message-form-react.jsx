import React from "react";
import ReactDOM from "react-dom";

import { sendMessage } from "client/chat";

import "./message-form-react.css";

const container = document.querySelector(".js-message-form-react");

function MessageForm() {
  function submitForm() {
    // Invokes sendMessage, that, in turn, invokes Ruby send_message method
    // that will create a Message instance with ActiveRecord
    const input = container.querySelector(".js-message-form-react--input");

    sendMessage(input.value);
    input.value = "";
    input.focus();
  }

  function handleSubmit(event) {
    event.preventDefault();
    submitForm();
  }

  function onKeyDown(event) {
    if (event.keyCode === 13 && event.metaKey) {
      event.preventDefault();
      submitForm();
    }
  }

  return [
    <textarea
      onKeyDown={onKeyDown}
      className="message-form-react--input js-message-form-react--input"
    />,
    <button
      onClick={handleSubmit}
      className="message-form-react--submit js-message-form-react--submit"
    >
      Submit
    </button>
  ];
}

ReactDOM.render(MessageForm(), container);
