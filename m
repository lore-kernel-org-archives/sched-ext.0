Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DD1DC198;
	Thu, 16 Apr 2026 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362194; cv=none; b=XMZGHe6TXEV2O03mpTcHp9PdbbNEVWksZWWoaSty6DDQKYMFJWlsppgVAXUyQ0u8tMGfz8BClAabSUQH6AkqVC/W7lJAvMzVw5IHa8OMPhSUpaHKPZDGgyONV7Zi9IHRjlh+UB35ChkHU/T6Az4S0wFbrpch6o48S3FEJWkujBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362194; c=relaxed/simple;
	bh=KdcGpKLRC6bvMX3dEy0yvIMgE+RyJc8GyiO/VJk+TWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATQ2o5ev2PIM2Tn9lNi4YNZhXwY9jBJF9ljTrPyPqOV9NnvJ9fG4GRUfi/Jw3N1E8km9TjB3G477jk7pLZyF+1D7v9RvBTWeIXiTc6RbfbB+bTSS9Ro4soqne2O69j6o0UpUyUwus1O47s0O9ipCdZavxxcdATQRigkYI0x8qBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpwYdJD4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpwYdJD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDF8C2BCAF;
	Thu, 16 Apr 2026 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362194;
	bh=KdcGpKLRC6bvMX3dEy0yvIMgE+RyJc8GyiO/VJk+TWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpwYdJD4zJSsuKgCwaO4W38faG5WN3rCxb5YzNk/+cyzkQHrxPbNgql5bVKXQ/RkB
	 sxmn4vWrEVANNBT//EIW/CBi4LvzQgrzDuC5DVU4Y2zW+DPkKEOCYDEPlxJdLXfmpQ
	 EAhPL4uatR/7FepuRH7PCh3icZ5uMu6hazdzWV113gW45FR6fr9d/Z4X5iBOzRx0mj
	 JymfFdg+V0XUqrTdbpM1B+D2ewN2oFOZlYKY6q9UYXsMk2KyG1BOsDjpFrvaxZ9RYg
	 b6Unq7K+QmmhlDyNDCW69Rwqg2/pwO8XJCOhZhHyOjJ/Rw8Kz34Q5Rg4MtQ8kC8VrM
	 cpnbRE8/AxUgw==
Date: Thu, 16 Apr 2026 07:56:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Prevent RB-tree corruption in
 scx_bpf_task_set_dsq_vtime()
Message-ID: <aeEi0X4Fn70bUgva@slm.duckdns.org>
References: <20260415193459.933175-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415193459.933175-1-yphbchou0911@gmail.com>

On Thu, Apr 16, 2026 at 03:32:44AM +0800, Cheng-Yang Chou wrote:
> scx_bpf_task_set_dsq_vtime() allows modifying a task's dsq_vtime without
> checking if it is already enqueued on SCX_DSQ_PRIQ. Since dsq_vtime is
> the rb-tree sorting key, mutating it in-place violates the BST invariant
> and corrupts the tree structure.
> 
> In ops.dispatch():
> 	p = scx_bpf_dsq_peek(PRIO_DSQ); // Get a task already in the DSQ
> 	if (p) {
> 		// This illegally returns %true
> 		scx_bpf_task_set_dsq_vtime(p, 0xFFFFFFFFFFFFFFFF);
> 	}
> 
> Fix this by adding a check for the SCX_TASK_DSQ_ON_PRIQ flag. Disallow
> vtime modification and trigger scx_error() if the task is already queued
> on a priority DSQ.

If the user updates the vtime after inserting, the tree looks wrong but it
won't cause crashes or anything. Later insertions might get confused in
terms of ordering but it's a rather obvious user-shotting-their-own-foot, so
I'm more inclined to leave it as-is.

Thanks.

-- 
tejun
