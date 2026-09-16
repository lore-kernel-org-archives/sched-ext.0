Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955D4E06CE;
	Wed, 16 Sep 2026 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592507; cv=none; b=KgDApW5t+cnrd66LCZdxlYfEj6KY0bpA6iQpybEEQom1SZXnXfTDSm/loa28p71Uji25FFVPU7HugnSKEW5IciJ6E2VCERr8JDSRoHqnEQIuQKk0BrqLBijyZCaHf09BzRIRoDzQPSSlUr2jRCfaFJLSMYDdLL8f8kIEAVN5tSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592507; c=relaxed/simple;
	bh=FPVEriJJX4KAcngx7B7+Ma+RWtvonEN05DyS34IrL4Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Jd0+PBvPd89VrWlfAGdZhFTixTCY/8CCPXbkeS80Xpgt65ETa1q6hokqmr3n8cHgxWTDHYDCXGhJc1vd7xxe0YZsTRzDzAYow+1di4VnUdLd8k2RBQwXGohpPIZIPrwy/jCKdcuvb/2PBkFgFUtm8NQ6mE1yuv6vQHkmlLNhi2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXqkpm7v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXqkpm7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F721F00898;
	Wed, 16 Sep 2026 21:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592493;
	bh=rL1D2Iba4W+TAG3RrwJMV4fvuii9tE6wuD+Xwm57P8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hXqkpm7vkFc571GzYe1wBCHZtPjcCeq1CbTMkZaNI+G7lQcxjEGY0sLejL3ox4wxE
	 9x7xHUMsC4Qv1AeU5w8pH+HFBpNxK1hC+j+Cc7kWjmqe1gUYZs4Yji7BPrpPPPJ0Yd
	 AqGKBNzYj2tpAKkGZmPKNF/bJc3zXT0OIkctM/jMP28jorLYdZHvXakzQ9jVIH2mlk
	 qA8Y2/iQpyI19wUidqmrXsKGyEMKCgU5xIMklFoBJZ1vuRfRqc6HkfEC24k/aFA0cK
	 8WAZHQeg22iNbVN8WHKpZYL4zAq8c2bcAMVP1ZWTInJ53HHhTm6KHlN3/KU8Mj2yAi
	 oiKboWdIFSnFg==
Date: Wed, 16 Sep 2026 11:01:32 -1000
Message-ID: <5044e1c6b6468239b8629e9a2fa8a919@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: Tejun Heo <tj@kernel.org>, arighi@nvidia.com, void@manifault.com,
 changwoo@igalia.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests/sched_ext: Test that ops.dequeue() can
 iterate the consumed DSQ
In-Reply-To: <20260916070753.3343113-3-fangqiurong@kylinos.cn>
References: <20260916070753.3343113-1-fangqiurong@kylinos.cn>
 <20260916070753.3343113-3-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Qiurong.

On Wed, Sep 16, 2026 at 03:07:53PM +0800, Qiurong Fang wrote:
> + * ops.dequeue() of this scheduler iterates the user DSQ tasks are
> + * consumed from with bpf_iter_scx_dsq, which takes the DSQ lock.

"the user DSQ it consumes tasks from" reads easier.

> +	SCX_FAIL_IF(pthread_create(&tid, NULL, run_workload, skel),
> +		    "Failed to create workload thread");
> +	pthread_join(tid, NULL);

The thread doesn't add anything. Poll from run() directly. Its own wakeups
are the workload.

Thanks.

--
tejun
