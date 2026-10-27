Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098334;
	b=2rpdB4bPSKX8sK/D2rtue8r/SSOGkKKan0ADE/FRYD2OLpu1Nt9ySzASHWsKoDuxnIQ5
	 juYtSgSR0EvQ0LpFXkuVs/8nAlTU7igA/Z6G4c+bogCea7jcV5MAWxvNMR9T6kjliCYXr
	 7mHhKsHPFvnx9z/yQrNu377wwyAHcnaoM0tvrTtJu6AyzPD9MynT2gvyuuUoOY0EfIs/u
	 fywfmaJwf3eUVEx+d7an+AdtRF/R8YkUKF9c8KMe++zkt0hlCd7KN1ck/A+9z+TMbFhUl
	 HZwYnze8L9H4j4f7ulPhUUuvefU1axGMELDpwfRAqUXBQS4OLRjb+Y0CRcZS/1S6vVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098334;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2I2PxzgejSBuKf/QP6i6JXoYjXhDprFyLqswPdIpp/A=;
	b=yDdHN7PSJAAQ8LckUR1GaPOaT4MLvbbhpscMQZxXi7ORHf6jQfrZszqzN56FYrcefhUX
	 s/LOoJ4l22M7CJGrC7c0GC7xmPfd3CFW1geivb1F4DiHsflK1SIbihE93DQZ/+MSB/RYa
	 NydrhaxCdK36DMIX/VKG+X3aJo6i2HCZ1gxUkn+VgiXKEk3hlH63mzGgV5ruB2nUt3zwm
	 u0gwzLKxE3vHgBe0dz6KYgVxwPrI/HXQMfkZFYvOdUElzuyKrUQaeH6EvnqyfDmYR39b+
	 Aozbrs4mUJComvSwrIKP/z9QCU7V+XUwOV02lCpfjZMMtAr/tW/xkWtpNubLpRZAlgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=fUZ4aDOL;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE7606A31A;
	Tue, 27 Oct 2026 10:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62AE7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=fUZ4aDOL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2I2PxzgejSBuKf/QP6i6JXoYjXhDprFyLqswPdIpp/A=; b=fUZ4aDOLPU/eZA7p+R1NIaLw5K
	91YLuAjmpANhsb3GbJrFc7wG4qeA1XXBDOTTJ075wQoeNxaeBx4RBPQMDws993PGIDQfhRleaiYua
	+p64u0s24u6GQg6n10C3B6mXeusjIPRPBON5/y0OCoUHdRtaI1G/eABPa8w9oBSBj+Ws1U9vrN9nM
	ySHOs3sgSg3dnQAfK5XSQ5HUJ+V1/S5a/WAQRFzyyWg+blVv6jABhzKB4k9S7UFi7OvI6WGiT/uTt
	2q4J9uObE0+8O9gk7a+NovQV8L+lngak+UPtFBMU+tiR88idjKFOD8yDaRSGn+LUKy1DRff31G/mD
	3tLMsFOw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLemo-0000000EkcQ-1GnM;
	Tue, 27 Oct 2026 10:52:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 411F0300DB9; Tue, 27 Oct 2026 11:52:09 +0100 (CET)
Date: Tue, 27 Oct 2026 11:52:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.5] sched_ext: Add NUMA balancing
 support
Message-ID: <20261027105209.GF2668564@noisy.programming.kicks-ass.net>
References: <20261027041536.3317971-1-arighi@nvidia.com>
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
In-Reply-To: <20261027041536.3317971-1-arighi@nvidia.com>

On Tue, Oct 27, 2026 at 05:13:29AM +0100, Andrea Righi wrote:

> Ideally the ultimate goal is to give BPF schedulers both controls that
> NUMA balancing combines: moving a task to the node where its memory is
> and moving the memory a task uses to the node where the task runs. This
> series provides the first: with the preferred node available, a
> scheduler can decide where to run the task. A second series, to follow
> once this one lands, will provide the second: a kfunc that lets a
> scheduler request the node a task's memory should migrate to.

Fair has no real control over the memory migration part either; why
would you want to give BPF that?
