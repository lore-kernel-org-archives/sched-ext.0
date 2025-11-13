Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5DF307AE4;
	Thu, 13 Nov 2025 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058744; cv=none; b=C5EKFf/nivMbRWjJ3N85c5U7zqC0PUaNLwRFEl97lhwMItkuwZWleDshtm3WATlG8N6+IkdBMNAoUG10XdT8/Rouv6aUlIJ69Y831qapPRvNjrj8Nsl2iB6aCPBCmZFmuTDKmHYvDlvlYMqgBEMPSQLzbIOPQeJ/C7AWvVG5qNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058744; c=relaxed/simple;
	bh=HNx96eeNZ9Qv9bLgfUVhrrc9MA5HgANxJdWbx3Ub5Zs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=UNe7lPwOxkutghvW5F7Nz7mB1ACeenFpOtQ6iiUqx3TbiPpciDzJsyXLEv9SLL/FdKmByNmatpGrSZ3KPmSFB5ho22CLnJ0MzVdWPNq7UnRqm/6gfpzcVtCgKQqtBRJoIIp88UrI9BlI2TESPkdHZrl56JAQftGyXYqzOzhRv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMzMwn0c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMzMwn0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD95C4CEFB;
	Thu, 13 Nov 2025 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763058744;
	bh=HNx96eeNZ9Qv9bLgfUVhrrc9MA5HgANxJdWbx3Ub5Zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NMzMwn0cT9XrXpR5neBvt1Qoog6iEnhBDZPzn6uJzhSJtwGqRIS//s9cqs86lCbZj
	 zEBIzQq+su4LBVm5XDF7NVdvHOqd684iKzRjbwrNGWWOr1R4Uhz7RAL7e7lYojWOUY
	 Q6icyCEsT0gN+jyFt1j8zmiInL599m9f4nqWk7YBSbuNd6I18N6jgahXftv/6CaKT3
	 kT2N2ExF7dFU99zcfhUMRfrpOxEaFgj7xGw7RsCkEuUZvQeJInAlbxTFyfL0XHwGBR
	 jddoAwfbLMvVyORng1S0ZF9yFVdLlwFV1yiPbg5nsbot/CUMwhktK9plIHaHmOw4B1
	 kYDAvusSL7eIg==
Date: Thu, 13 Nov 2025 08:32:23 -1000
Message-ID: <001184f0619f11ba3dc767e237ba99a5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix possible deadlock in the deferred_irq_workfn()
In-Reply-To: <20251113114355.24572-1-qiang.zhang@linux.dev>
References: <20251113114355.24572-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Thu, Nov 13, 2025 at 07:43:55PM +0800, Zqiang wrote:
> For PREEMPT_RT=y kernels, the deferred_irq_workfn() is executed in
> the per-cpu irq_work/* task context and not disable-irq, if the rq
> returned by container_of() is current CPU's rq, the following scenarios
> may occur:
>
> lock(&rq->__lock);
> <Interrupt>
>   lock(&rq->__lock);
>
> This commit use IRQ_WORK_INIT_HARD() to replace init_irq_work() to
> initialize rq->scx.deferred_irq_work, make the deferred_irq_workfn()
> is always invoked in hard-irq context.
>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Applied to sched_ext/for-6.18-fixes.

Thanks.

--
tejun
