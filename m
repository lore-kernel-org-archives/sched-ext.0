Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940F3233F4
	for <sched-ext@lists.linux.dev>; Thu, 27 Nov 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239979; cv=none; b=HH9WmCh2tLoaf1eLODXXL+3A/48jQoIKAy7FZc7OBjC4Qh50wILxCf/l1xRmHABwuQLiBGPxsKSkjqrhf8KcWsPUxLX7lgIyhM2BM6Pl55T/WzbTx3WH/73J5KsHP2Qd5/mCOrM+qUYT/K4v1eHugBIDbMHYm9LsRdRVh2ZGTwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239979; c=relaxed/simple;
	bh=9psqYrIv0eFQ6vtEA+yo7se3T74TLPtnsKpZBy8r/v0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mC8KN13c/Oxv/I7NyXnZCf6/IuwydPDnOetx+YxdmaaVpYsYHtKORdn1NcRzH0Mmy9PR4HOP9oZmCtfnCC/XmxDk2vgemE6MqydB3lENGRyaTx6XXoQTHa4Wz1h1yVgSBpMYfFyZ8GgWCVFAZxTGkrm+IBtTH9jXmPyQ8JNyM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBXTui/O; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBXTui/O"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47797caba11so3045715e9.3
        for <sched-ext@lists.linux.dev>; Thu, 27 Nov 2025 02:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764239976; x=1764844776; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lqAp9KVCPquz913n77B6yJ7OoUi8d/Wkn+xOGKClAHw=;
        b=CBXTui/Of9HlSlqGS6R6JvmR10zrxdizNemP80mTSIUKA6aRlAAgaweHQ+6em+auls
         +3WY1heo8rRKUDleGVpFB8FbezXXHJzGziw8Qh1EGv0TdewogZ+JXMYxibnOHkpmE1UC
         REmug7FcenrzLy1mwwpiw3320vpi3HSq3ZCyC+B1U4cIY9j3DpfylGZH6jhQdNKbpJNK
         dO0R/oCTzjK3IdCfNrzxHJTrV5snW+qy8oYqVuuh4BroMRoyGUqilp/eZp/Z7ksCkYXU
         vxtnVR+tk+EWuMUTyg7BBvbHGQj4BqWsf72jcflQjKONbMJiPdwpyDqj5uqoemzSipAX
         PZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239976; x=1764844776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqAp9KVCPquz913n77B6yJ7OoUi8d/Wkn+xOGKClAHw=;
        b=f2sigmrjBAEIm+uhLw6Gr4WKyfbX9aQby3bSlYW7zcdyIGfFeOGLgmzzsHsOr1wo9o
         e5kW4v7i+jdRetovKvRvg1kAqgbS7AFcQStUOJDSFoUMmYK1GuImCWRvsgAx6t7X/d2W
         ychcVoR1hn083zLLiv5Nx2qhUHVbod8IKawLjFLIKuJXgh/wvghd1BAjx+yYdfLk2at3
         R2HAARmqvNxXiFOhjQAr5rx0mzmHc+WDaZNSy56SCUTKKg8BU0X8v6HGdA84IpcXC7kX
         RLlXsA5595zgLJaVPC1MA/3GW2hcOyJptAX6YZefkUKxWy6g3jyIrElkszjAqJ5yIx7I
         cIew==
X-Forwarded-Encrypted: i=1; AJvYcCUEZF41VixLauFEv4ED4DKniReTL2Ks/Iv6WvfluoZuUwHK3iQv2TDBT3YlRb0nHGL3a1Pu36Qn28Q=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6Riq0Y4pNDV4opcLy6rlwRc5KbVGAtLEg4DRQDBC+s0B+YOB/
	w4zUZcnG+HP1l2cunwDs4LuJ3vjH9uUX+rCifWRObH16D9Fb6RDW6m/248l+TTh3ySejWsY5rLy
	3RczpK0i5k9hGXg==
X-Google-Smtp-Source: AGHT+IFOu1KDxS4wOpjUJIiOlRei4monHQlN4TXIIv6EXMYnI0d7/4TU+UcTmPQbCkMIeBY6k7kgsQpI859Wlw==
X-Received: from wmbjp25.prod.google.com ([2002:a05:600c:5599:b0:477:a181:1922])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46cf:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-477c1103015mr202856565e9.5.1764239976616;
 Thu, 27 Nov 2025 02:39:36 -0800 (PST)
Date: Thu, 27 Nov 2025 10:39:35 +0000
In-Reply-To: <7e9b27d70e31c243da3ce77e622b0af5@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251025001849.1915635-1-tj@kernel.org> <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
 <7e9b27d70e31c243da3ce77e622b0af5@kernel.org>
X-Mailer: aerc 0.20.1
Message-ID: <DEJEVK0YKMWY.116BVU5P5G91L@google.com>
Subject: Re: [PATCH v3 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <andrea.righi@linux.dev>, Changwoo Min <changwoo@igalia.com>
Cc: <linux-kernel@vger.kernel.org>, <sched-ext@lists.linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Wen-Fang Liu <liuwenfang@honor.com>
Content-Type: text/plain; charset="UTF-8"

On Wed Oct 29, 2025 at 3:49 PM UTC, Tejun Heo wrote:
> Schedulers can now use standard BPF mechanisms like the sched_switch tracepoint
> to detect and handle CPU preemption.

Correct me if I'm wrong, but I think using the sched_switch tracepoint still
leaves us with no preemption notification in the following scenario:

1. An RT task is running on the CPU and blocks.

2. pick_task_scx() briefly drops the rq lock in balance_one() and the RT task
   is woken up.

3. SCX sees the enqueue and returns RETRY_TASK from pick_task_scx().

4. The RT task is picked.

5. Since prev == next, we don't enter the is_switch branch in __schedule()
   and the sched_switch tracepoint isn't reached.

The BPF scheduler could hook into trace_sched_exit_tp() to work around this,
but that tracepoint seems to be for testing and debugging purposes only.

