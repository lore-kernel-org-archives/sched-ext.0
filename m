Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609650;
	b=EkT5kKoTKZBOENyKvKEw19f4FLBuGcjZ/EtUP6ahWII4bTS6mOVGODncX/ADAqW2a4n/
	 2DNMxNppAr3kgR5tzWqOvWHbkIynVzPTcIQ0jwecuau27ro4ay257lxsHoWKe0qAjJaey
	 P7saBrShpk5yWFQcFtoPBz0naNGy/nN7ENkhGXjjD7BDdJRqAOY4KLbSPVYeKbq5KgrCG
	 p3dpdjXwlcoZ0a9M+lhw2B8lxB4eZ3u33bJmNPDuytEDde3iR+cYQFeeZsP6LxBfB4Ddy
	 P5y5aNO9vw7H7O+tgsNfIkCSJjvXO5cw8698hcpaLEgYOY1pdvoUN+cq5VGwsCOHwWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609650;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=7FMfhnSAl6K553trS90hbpNrDLMIboWhRP3ah5uLrY4=;
	b=Uj3SSOUaWevQCf7bSFjoUjyHdgxDSCe4OoEg2wmBoR3HwDxeRYeesbARTWW42HbvIDTv
	 vXyvqk6mTtlUa9ORfpgbC8iWGZYbLYufDbqBR7JVnPQ8S0KAhyFIDpSsNfx0D1XY5q0hb
	 nya7lxAbCknuYzL9cZuUVeYbkf+0CHOixgCqGwyAeEGoifZbTr6q9+SF3EUi7bXUnHA+Q
	 aPOb/VYapaEvdgUSe1eHQUTnTzz5Z05QHS6h0WlSFUBD+Ku7ksOIZyo9ffzLLodSOxtJH
	 6E54b09C+l5KDH4w6ut144dwjA97Swt7f4JCpIkZOijwbJpbwZ68MPHvGQj/iVcgluQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WoGPb5Op;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D00606A319;
	Wed, 21 Oct 2026 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WoGPb5Op
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADDD1F000C2;
	Wed, 21 Oct 2026 19:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792609649;
	bh=7FMfhnSAl6K553trS90hbpNrDLMIboWhRP3ah5uLrY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WoGPb5OpWYOgL4N8Iyb1W3FoopprR6C9DyBk0RzvBvvfAL+fJuYJfKLTVdjT2Jf+e
	 zri4+C2811yBDVjrQGKEQcnnde4aSyejWPjdmy/adZrFQbTkpe/fuYxspIRd8wd0K9
	 vzt7+pJAeooV8S7jtPszv6ct/rygWf1n7jRziKXAC7ghmQTVRb+OT+HYwAfOkAaAg7
	 nPk/OHIrw2jpWLV3mPcRZ8BVjHPQp1jqba5kgU1N/S+C3EMhKgncWLabTsfa8AvEPk
	 coqIISr2TkJZCMbdS+wzTbRrOTjakqhaN9hspaOjylpTuLsoWVUOjZg8hHuE589xKl
	 7Svk8NdJGaU7g==
Date: Wed, 21 Oct 2026 09:07:28 -1000
Message-ID: <7350d12ddf2d800823dfc1366e91ff2d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	John Stultz <jstultz@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched/core: Avoid requeueing a
 singleton balance callback
In-Reply-To: <20261021070535.1256337-1-arighi@nvidia.com>
References: <20261021070535.1256337-1-arighi@nvidia.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Applied to sched_ext/for-7.4-fixes with the following tag added:

  Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks.

--
tejun
