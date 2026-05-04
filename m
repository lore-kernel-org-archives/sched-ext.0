Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8233E355;
	Mon,  4 May 2026 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928744; cv=none; b=A8mUCHOdKrM92ZAv3vmBufE+ql9UfvWzhzic1l0lqrq66u6l4NLleB+ELnLcmiukAtlrC+Vk6wjVGxyvi1CsW8CB6nKpU+NC0zxr34xAXWfriJ2OvB9JBLz+qpn9IszRWDu5F/Iebvt8tVdaQJpF/xOrx1FVtHmvACXmdSZzaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928744; c=relaxed/simple;
	bh=D68CSF7zNw2sDid9jA+oD2PXi+2x+O2oOmU+W44U8Oo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=sCFYbIvdA9rI89lowyGu9JgkqtQry72P5XhkmAI8QykM1jc0e7dvqOKh+4efQUVzL/d7VOQw8pduTNKAdNZ0xseiZzBI/Wjrf3uE22eGBM+HpE9bJ9ZQ/mkhHf0oFLwMzEN7Y+BdIpN4fWSRYvSyYQKOcwlhFrcytvJPTw3/d8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdzTh3jK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdzTh3jK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B514BC2BCC4;
	Mon,  4 May 2026 21:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777928743;
	bh=D68CSF7zNw2sDid9jA+oD2PXi+2x+O2oOmU+W44U8Oo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZdzTh3jK6vt2d/NUTnT7Nhg5GEoVJp+5GV9BFfv/pe84bWmyDNMOdfO6cMmlTk2b2
	 NvelE2ew+ndr358c3UVwewTa7ZJH4Gdmp2K/3EKk4ZruYnt+OztDeVK8Tz3ZPsdrH5
	 +mdcYsuQ9DwPKStYLOQUjBviZVxgnZeXussrpZtwupYni9KmYvRMX9MSseT7euWIAo
	 sEYHExng3LyMh63VntZsoszTWi9GQ7su75iK4MeQJWXse9u1u5KZjfzU5EKi4eN2Av
	 b3a/ll6Eftki+uT2GKyftX2WOmwckNjnanoIAVFJa/tPbx1aA4P7Ovy7KfSqkbBGDn
	 uhd46+9/DgnMw==
Date: Mon, 04 May 2026 11:05:43 -1000
Message-ID: <0e038f18af2a809b9ed3c179b1b285cf@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: idle: Recheck prev_cpu after narrowing allowed mask
In-Reply-To: <20260430092747.73114-1-devnexen@gmail.com>
References: <20260430092747.73114-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1-fixes with Andrea's Reviewed-by and a
Cc: stable@vger.kernel.org # v6.16+ added.

Thanks.

--
tejun
