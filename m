Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615051;
	b=JUkiEZz8o9CWCeOCdre7+tQSX6xoi6QFxmsIZ6I8szyhunwe8tCZVIV/fbFAQtoCT6PA
	 +kHMNHPL4pqDwJjyxEHjYrzp1eJmhChJxOAmx+yUidfMzPhFm/h7Cx07sgP1FAkqT0ECs
	 qzJ65oHU6j0OueVjkjGXWbChxxzesbyHBa1f4fKF7IKo7NZscrrhNp5xV8if7APbxMpN4
	 4aldbCcsp3LHUvyfS8S7Stv8R8jl8+yrvjZMRsDMun4q73AimBRKQL/IA5vYHZEA5ygI8
	 ebJqtKwaAGsuH1NnXMgbxWV3CYhUYeouE9QlDJi2EA64Hu/tsWNr4EiWE9IFrPW0NPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615051;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gOrWyrBHu08rumkxjoyMPHrvfJq60EHLDWwwyU2TDXw=;
	b=eMxiDHlu1W7DP798dTMBtCOg5GArTQBE2XDX3IZSb+2ycyOkvYWPCUL2cz1CjxlwYBEA
	 xkE4wcTJjMEaBtKxO47AQ078Ser6UucbQOgW2p/7yssS+q3IFIgKvAPSWwxnVSgU3OxNa
	 ODAO7UO9x7vXCH2PNvsO+WiyLveUVDt5M6QsMFOhN2pTsO5Fmgw/jCUVDWo5aE/75Y6tC
	 XQVAPu59Mf7bIWmhvVws3Mri/ujEPuYvLktenSt8GvsNBXEVrdrb1qo4WwHxlVNm6JV6x
	 2p1JT4E+47zoCBZcRCx4SvTWJwqdKk53UBPkINBuEWSUBwRDWB0aXdmcE8W72PenHtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Te9hgV1v;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34260606A321;
	Wed, 25 Nov 2026 13:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34260606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Te9hgV1v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gOrWyrBHu08rumkxjoyMPHrvfJq60EHLDWwwyU2TDXw=; b=Te9hgV1v6uYq0M1ajAcGUIIcs3
	hW2RnD5SP0gzH2RuCUpJ8/JsC32feZdOP2cJG5PytdnX7jSoJkbZwWzEIOIo8DbL62zhlAOk8kDSQ
	/8mnf/fQNbZhZ/qWtWJNJyHKhgIxSZRZgJTru9ERxQrA0DlzRSRm0hXKiAEyTAqr4euGf03lAdLpL
	KyTj77b49He2p/xHTwsd5TcndZBWRY08ldV4P3VcY1DAyA2oAGjj/fxh/cr4U0da1PfJTeyF2IomI
	KlkiQmKzLSFdmbetoP/i9y8MJRQcv7HiFNeIHbmfJM3WrsCtl+Ub9sZQvjjf7Epd+cYRELG3HwwlI
	YbZ4CDjA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWDUz-00000005N8g-2QVo;
	Wed, 25 Nov 2026 13:57:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC1693008BF; Wed, 25 Nov 2026 14:57:23 +0100 (CET)
Date: Wed, 25 Nov 2026 14:57:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.5] sched_ext: Start ext_server from
 the tick
Message-ID: <20261125135723.GD2668804@noisy.programming.kicks-ass.net>
References: <20261125103420.2785659-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125103420.2785659-1-tj@kernel.org>

On Wed, Nov 25, 2026 at 12:34:18AM -1000, Tejun Heo wrote:
> Hello,
> 
> ext_server starts when the first task is enqueued on a CPU's rq and stops
> when its pick finds no task. As the BPF scheduler can run a task on any CPU
> whichever rq it is queued on, tasks can wait for a CPU whose ext_server has
> stopped with no enqueue to start it again, and a higher class task which
> keeps the CPU starves them until the watchdog fires. scx_central with a
> SCHED_FIFO task spinning on a CPU shows it.
> 
> Peter pointed out the problem when ext_server was being added [1]. Hang's
> recent patch which starts ext_server on every enqueue [2] helps but leaves
> cases like the above.
> 
> This patchset also starts ext_server from the tick, while a higher class
> task is running on the CPU:
> 
> - If the local DSQ has a task, right away. This covers a task which another
>   CPU inserts after the pick came up empty.
> 
> - Otherwise, if any task is runnable on SCX, at most once a server period.
>   Only ops.dispatch() can tell whether the BPF scheduler has a task for the
>   CPU, and the server's pick calls it.
> 
> Whether any task is runnable comes from per-node counts of rqs which have
> tasks, which a per-node timer lowers lazily, and a global count of such
> nodes, which is all the tick reads.
> 
> This is a departure from how dl servers are usually driven and there may be
> better ways to go about it, but it does seem to solve the problem properly
> without adding much overhead.

This is all pretty awful; at the same time I don't really know if I
have a better solution at hand either :(

Could you perhaps punt the responsibility to the DSQ? Each DSQ has both:

 - a count of how many tasks it has
 - a sense of what CPUs it targets

Right? So can it make sure nr_tasks CPUs of its destination are running
ext_server?

That might avoid all this extra accounting and timers you're adding just
to keep stuff 'running.
