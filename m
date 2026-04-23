Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F9C382391;
	Thu, 23 Apr 2026 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962459; cv=none; b=saLad2PRgcGBXBIeZRT0KMTvRqpPbKJtgsMfhH+mmKWoNC6plZgQzhbKpw3rukYkmZvmXY8sh6I6p0UyWmFkSFRS1CzlB5b74XXLJK3c+CG514bBukDibSiAAPwh2JUImH/FXKmXMnMAVTBUZaJObJyyT/FaXO2nRoxPKwvPHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962459; c=relaxed/simple;
	bh=yw9exZNO/QR57VikPRz5fmdCAqAo9AlZSxALOF0E5Qw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ew91wY4U3anf30fSIVAExZI1qWvdU8om963gLhGOhj7RH8EdyNsWBcfASznvybRR2uNSuAmkBDbvqYu6eXrOpyCCNa+YgzD5nyYDKvKMXVyEDAgyKGRrq7PlxkqnYGoUkcMidgvBW2VJgj3xfRTbCFYTF6iGqaCZB3JVfMuT+hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGkQ2tis; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGkQ2tis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA80C2BCAF;
	Thu, 23 Apr 2026 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776962458;
	bh=yw9exZNO/QR57VikPRz5fmdCAqAo9AlZSxALOF0E5Qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SGkQ2tis6aA+N6CaNG0H3i0zmqyxbx4FeyNqapKR7wT38IwNMU1s2awO1Ojk7I+zX
	 YE3XX2beRqr4da0X1uejD7OweYDmtr1Ixi6tfnTIGSP3viyynD4FHlKg9coM+4larW
	 b4GQ89880Ts7mAEq5l6JqTaHGx9+ZfrGHc//P4JI1rFFNl2AssHNEmxLbIAr4EPKIj
	 uw6pdV58Dp/P0xmZDYoXzSoSveYawv0dK/ly+HviBIcA33evOPr2cVTgp6s/60ffvv
	 oG3at7XiU82Lbgl8jLSdcNIHTkZsIiQ/qyVj2aiy1KU1vwVyesbtA9DqkuqZ9V5aG+
	 LYM//Q8TFgbsw==
Date: Thu, 23 Apr 2026 06:40:57 -1000
Message-ID: <2b058251bf415613eb89c2129b4045eb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhidao su <suzhidao@xiaomi.com>,
 Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: Fix local_dsq_post_enq() to use task's scheduler in sub-sched
In-Reply-To: <20260423025832.2654840-1-suzhidao@xiaomi.com>
References: <20260423025832.2654840-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Thu, Apr 23, 2026 at 10:58:32AM +0800, zhidao su wrote:
> local_dsq_post_enq() calls call_task_dequeue() with scx_root instead of
> the scheduler instance actually managing the task. When
> CONFIG_EXT_SUB_SCHED is enabled, tasks may be managed by a sub-scheduler
> whose ops.dequeue() callback differs from root's.
...
> Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
