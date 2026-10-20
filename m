Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456025;
	b=fi4d6jywLn6r/bNKrspWboJaqwFdD+PB3dhKzAi2Z9I1dXwk/mOogKwMhGZaNM61jKBK
	 4I3KKZfjQffwxyhZxOl3+N/+ns4aeu+q7cesI/soDM9tmXFmTzGh97rbF1AHPzR9VEWhD
	 fEvwugysjCD+aFJoy9jB1uvN2irhpXl0kd5Y+dCxwPgZr+dfCz1s/mO3e84jUwEYeEDR1
	 Z09Oa7uQT26/jRD79FxnsQz0oT89s9ZQlFoeh3zPkev6X9HZ62Fd1mUZnxXm2vAKH1tkV
	 OgxIFdiQb+TwDVUgSQoJMBBoDZiFfJpq35EIHNom+UG52OF0oH+1EAZIM27u5X4kpNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456025;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=B3F7kA1Dq0BTEFmIKNS4VjfCfEEYVS0La+GUC2XgmTY=;
	b=v9GnnkcT2kVH4uq34bqc2EfBNkn4DIyWn/2lyPV7/js2BiEHxo3a6oP046aBTnNPcHHQ
	 YOTlqsajB2maxjpx2g3gJhTnDsaO4na0iNSmcSrIsOwKGsQcJEXjEt6ZF0x963RGwwC5j
	 RwgT17IpQzbMYJKaVXXCi7EUHF25vKUpSBvUtZLsl8I5daZ8owlEzddr+LKZar0r5FwTM
	 F5sa+fxA2D6XiWLmkX9swIN+jCPbtezOYjAOvE2daaighAiHcDz1YxENbJRjcnic7dej+
	 lstTO8uXABbkprTkmA7fnZBIFs3bIz+Qdjo1SvfC7ukGnv4vk5ZMUgk1D8VWVC2Zt3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9zJX4iz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1EE606A31B;
	Tue, 20 Oct 2026 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9zJX4iz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B53A1F000C5;
	Tue, 20 Oct 2026 00:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792456024;
	bh=B3F7kA1Dq0BTEFmIKNS4VjfCfEEYVS0La+GUC2XgmTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g9zJX4izF01bCwJidOuWWw6Rf+k7Qq3u17asgSBpTsRN0NvCriOVwH3S32h6IWXZs
	 8MOMDudO0Zf0Y7Vo8z66qGUO37Uj4nQYSjpdPZUcGbvTj3HLEiqA5HuRtV1c+wKWZQ
	 ht48pYPupekUlR+G25ayUvapYdZhd7NYadGMzQruOPn4F4LglvbxKk1KoeEDDbVaoF
	 SeO0baEuPiXZHGU/jrx8b3kXcOkKiVXW4LhionZVVq3la3vi8Esat0DO0oxrrAXOAV
	 2Rf0ierOamtP1j1ybwx5q/ISc92IpvSRSbmmMbXeA5u1zT/vTchBnx+AV+5VweT8GL
	 cf1AVlLaZk05w==
Date: Mon, 19 Oct 2026 14:27:03 -1000
Message-ID: <08cac02c604dd73ef96fc92eb29d692b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4] sched_ext: Queue the kick_sync wait
 from set_next_task_scx()
In-Reply-To: <20261018162415.55913-1-arighi@nvidia.com>
References: <20261018162415.55913-1-arighi@nvidia.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Applied to sched_ext/for-7.4-fixes.

A few follow-ups:

- With proxy exec, __schedule() can call set_next_task() twice on a
  repicked donor (SNT_REPICK, then SNT_PICK), which queues
  kick_sync_bal_cb twice. When it's alone on the list, it ends up linked
  to itself and the wait runs twice.

- The foreign CPU check in kick_sync_wait_bal_cb() looks unreachable now.

- Not from this patch, but maybe_queue_balance_callback() clears
  SCX_RQ_BAL_CB_PENDING when queueing, so a proxy exec zap leaves the
  deferred work unscheduled until the next wakeup or deferred request on
  the CPU.

Thanks.

--
tejun
