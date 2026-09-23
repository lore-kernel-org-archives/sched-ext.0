Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC5495037;
	Wed, 23 Sep 2026 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189958; cv=none; b=kzX1oJRg2dmAd0L5iy72b1DPKoJH++9JZ5XpoISCrw7KHtN9tbshphU53D1+F+zQlDkVQg3BXsX3oLkgoXQnzg6NgWUXVgt7c7NR8nsY8Vyfv09uiedWmhc7l6UNWSH3gZABHbSNQXwtA7CNJ90/gITqOVOIuy4rZ32KKvY5nmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189958; c=relaxed/simple;
	bh=YnzNba1uuRhllBwFJYI8SdVTn2LoAWh2vPE0KLyn/xg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ZmZLqnh/FNRrmJ5u6zEouWzilANyUdRGW3E3eDHmYiL9ojVtsu5noaiIWC+pkov47hHNmLUzR83YMpKKdguu8BygsU7t9JCV4C+ZDQ/974h6I8fUsrQP40oSMLqlVxsh4J3Xrj9R5CX7ubF8qe30X95MXzvSrgjYw5nGvYNLzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRx1BQmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRx1BQmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21931F000FF;
	Wed, 23 Sep 2026 18:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189956;
	bh=/NeSA8DVk2ilaVt7KJ+BPCe9UE1my0uOPhiixkwDHNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JRx1BQmdnRvG0noJzX/iqrNQtgNaV7TdzUfIlImfzU4t9v7DWWRrtw6J9qVgmmmlU
	 nhk54zDQi8dN7eaYbNkBzWvW9KBW9hx7nxgGNdIBbMGVPyFk9rUhtsYzSCgNsDjX+r
	 wEZa8JU7VjJqfVmRVM/sS6ZOhl4s5fpLQskOUNmsX3E1d3oi+AIC7iSYd2w6s9Oor/
	 Jkt+l1s3h+8hB6hG764abMXhK0jQ+eOxKHUzCMOyLDTFln2eXwpVeMABXFHZGNJQB+
	 wJq49LINmdmmcsITwtDit5sWmIolB6igtuv3/hl5skVZFFHMNlWv8ApABAOwGDwEow
	 X75JX5xaUFglQ==
Date: Wed, 23 Sep 2026 08:59:15 -1000
Message-ID: <15d491d4d4fb481941e8495d48b5c610@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: arighi@nvidia.com, bsegall@google.com, changwoo@igalia.com,
    dietmar.eggemann@arm.com, etsal@meta.com, juri.lelli@redhat.com,
    kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
    mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
    sched-ext@lists.linux.dev, tj@kernel.org, vincent.guittot@linaro.org,
    void@manifault.com, vschneid@redhat.com, yphbchou0911@gmail.com,
    emil@etsalapatis.com, david.dai@linux.dev
Subject: Re: [PATCH] sched_ext: Avoid relocking DSQ during remote consumption
In-Reply-To: <20260923140750.2128382-1-usama.arif@linux.dev>
References: <20260923140750.2128382-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4 with an unnecessary line break removed.

Possible follow-ups:

- The !dsq branch comment in scx_dispatch_dequeue() only mentions direct
  dispatch as a source of holding_cpu. Remote consume now reaches it too.
  Can you update the comment? The dsq branch comment also names
  dispatch_to_local_dsq() as the racer when it's
  unlink_dsq_and_switch_rq_lock().

- The remote local DSQ branch of move_task_between_dsqs() has the same
  relock. Calling dispatch_dequeue_locked() before dropping src_dsq->lock
  would avoid it. scx_bpf_dsq_move() isn't widely used, but it'd still be
  nice.

Thanks.

--
tejun
