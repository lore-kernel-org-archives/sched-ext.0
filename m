Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D71799F
	for <sched-ext@lists.linux.dev>; Sun, 11 Oct 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738690; cv=none; b=IX65R/66OMQMNMsMvkuS+7gtTaVAmhENOdy8GNx8VvCGrm7eNuLkmBS2T/5gWw2omth1fWjiUrMlaRlrz4+EVAkGouMGq3oR8msUMJ9zDKk5F/d92NG468niWRfqvbwGyaiB4xZbOa5JWcWmmEhfYrUy99Hso88rDM6fJPGjloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738690; c=relaxed/simple;
	bh=oyDBxZS+LvhyzScug2ls846IS3pqP/GArQEKPFYIf4Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9CZHp2Mvb3iogA2FkBwKKKar677WuPMLUFeX+aQ5ff8x/7fGsDEQ8jTTxECL7nlMpAjB6BcTwH454XKu+TsOYCXgSpghPXCHpQmpggASZfovAc+i6ubho7F7c47d/dfoDBYWZ7wBI8LyKUiBoF434hvcrjHDKcShDlpxokQ7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ji9ME9+v; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ji9ME9+v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:Message-ID:From:To:Subject:MIME-Version:
	Content-Type; bh=oyDBxZS+LvhyzScug2ls846IS3pqP/GArQEKPFYIf4Y=;
	b=ji9ME9+vgAj1xa2qc/GVU/ooFBwr4JYgdnIlzr5Ch+eEJxFWQ8NNjm0UWvnbEt
	qjwPfVxkfmJB+66P57qiMoudSNAyEzBVn4UUPb6t27wvwrtmN+8ToR4QtKp5mVQV
	pN9QnRteyMMZJvPU/kEGhaZusPoNCowXThY+rqHd/AUG0=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3L77awstqK5YCEA--.1926S2;
	Mon, 12 Oct 2026 01:09:48 +0800 (CST)
Date: Mon, 12 Oct 2026 02:09:46 +0900
Message-ID: <d4c69652718677b25a157eef31552bad@163.com>
From: Hui Su <sh_def@163.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: idle: Respect task affinity in restricted CPU selection
In-Reply-To: <asufkdwCQvilJEqr@gpd4>
References: <20261011025256.4180374-1-sh_def@163.com>
	<ass0dexwariQCOtC@gpd4>
	<20261011131700.1351541-1-sh_def@163.com>
	<asufkdwCQvilJEqr@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3L77awstqK5YCEA--.1926S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4rCry8Jr1UGF4UAr45trb_yoWxuFgE93
	sFg3sxXw10yFs3uFs7CF109FWUZFZF9Fy5u3yjgF93u34kGFZ8Wr4kJF1F9a4Fk3yrAr45
	Jrs5Ja4fCFn09jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1qg4PUUUUU==
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwhx11GrLwtz1LAAA3Z

Hi Andrea,

> Sorry, I suggested this, but I just realized that we break
> SCX_PICK_IDLE_IN_NODE if we do this. What if we factor the check with
> an helper?

Good catch. You're right that deriving the candidate from task state also
needs to preserve the SCX_PICK_IDLE_IN_NODE constraint.

I'll factor the restricted path into a helper along the lines you
suggested, with the candidate derived from task state first, followed by
the task-affinity, caller-mask, and node checks before consuming the idle
bit.

I'll also add focused validation for the cross-node case and send a v3.

I'll keep SCX_PICK_IDLE_CORE handling as a separate follow-up rather than
mixing it into this fix.

Thanks,
Hui

