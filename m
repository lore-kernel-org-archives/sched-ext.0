Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088447668A;
	Tue, 15 Sep 2026 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499406; cv=none; b=edtc60T4tGk+O+M1y91g1Wpj+uigl7/kRw4XGES2Ldi4q0z0NdC8ZZ4tWya2l5Yk5zZOqy9bvVxu8SF7xDR211CZ+Kcrx9r/YpUVSsjC6WNRYLgQLplb4KCyvAMSkh8XmYj7RbdmFeXfniuFIj1sp71BGK2hpWcBEDl1L1SJLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499406; c=relaxed/simple;
	bh=SfE2APAMaL1es2r8mgcf/u/jkJOX00j0G1WeKMDtYik=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=kHweUx39tSOIkf6c5t6JoII2Gj2xaU9iAA78424r9H5P+iDpc0MMNeNTg85ncmhZ5Ieye082gk7u7/+vqNJqtl12q8uUlxJG+Ptj1dN55+e4ir4GVnAamrTYCv+zXa50xiGulghByx5ByJmBX3ZEvZ+I7A4QAV8cxJSi+u6aHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1Xob7gN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1Xob7gN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3B21F00893;
	Tue, 15 Sep 2026 19:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789499404;
	bh=cNiEcYLy7D+tM5j8roDET50CSYnfyXH1nZlC9WhByX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h1Xob7gNphVhtJjAYfaA0wRio+giKWHXhBHk8J+Vkd7KW+Wxik7oDpbthg6Kng17B
	 +8VXwwIeNyLJ/Ak3Ttl05kjZIJyMGo7ArPuTt3HG5a9LWchTuKYYikYgCg+YeMH5SU
	 rOE8lus7FELvDfNtmG/WTcblf4HZeDgE5dfI/6NchXStMtXSrqmQXZPLG1F1D459KD
	 FDi+yQVB60OsYpXjheqbJwP7JGz/Np05K/4O5ItW3p165GspAq3HbksRsdY6cXB5gk
	 2cj88LOn8NJCN5HnN8wAMRWuUjMbVSSdZIeBOQbijxRZOaK4tvbohbjAHKaZTvko+j
	 O+skpytIz1Wjg==
Date: Tue, 15 Sep 2026 09:10:03 -1000
Message-ID: <116b78a3d3054246b5dbf5ab0759b5a6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: Tejun Heo <tj@kernel.org>, arighi@nvidia.com, void@manifault.com,
 changwoo@igalia.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/sched_ext: Test that ops.dequeue() can
 iterate the consumed DSQ
In-Reply-To: <20260915130334.714388-3-fangqiurong@kylinos.cn>
References: <aqkQ1MtqtqnS0wUs@gpd4>
 <20260915130334.714388-1-fangqiurong@kylinos.cn>
 <20260915130334.714388-3-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Qiurong.

On Tue, Sep 15, 2026 at 09:03:34PM +0800, Qiurong Fang wrote:
> Add a scheduler whose ops.dequeue() iterates the user DSQ tasks are
> dispatched from with bpf_iter_scx_dsq. The iteration takes the DSQ's raw
> spinlock; on a kernel that runs ops.dequeue() while the consume path
> still holds that lock, the first task consumed self-deadlocks the CPU
> until the scheduler watchdog fires and the test fails with a UEI. On a
> fixed kernel the scheduler runs clean and the test passes.

The watchdog can't recover from this. Both it and the disable path need the
wedged CPU's rq lock. The header comment's "wedges the system" is the
accurate description. Please make the two agree.

> +void BPF_STRUCT_OPS(dequeue_iter_enqueue, struct task_struct *p, u64 enq_flags)
> +{
> +	scx_bpf_dsq_insert(p, TEST_DSQ_ID, SCX_SLICE_DFL, enq_flags);
> +}

Without ops.select_cpu(), the default direct-dispatches every wakeup that
finds an idle CPU to the local DSQ, so the poller's own wakeups never reach
TEST_DSQ_ID and the pass condition depends on unrelated traffic. Add a
select_cpu() which returns prev_cpu so that everything flows through the DSQ.

> +void BPF_STRUCT_OPS(dequeue_iter_exit, struct scx_exit_info *ei)
> +{
> +	scx_bpf_destroy_dsq(TEST_DSQ_ID);
> +}

Without UEI_RECORD() here, UEI_EXITED() is never true and the failure branch
in run() is dead. Record it, break the poll loop on UEI_EXITED(), and check
for SCX_EXIT_UNREG after destroying the link like the other tests do.

SCX_ERR() already appends the newline.

Thanks.

--
tejun
