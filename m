Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2B30F95C;
	Mon, 22 Jun 2026 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162346; cv=none; b=JIBs7QPAaiu7H7E40ngKpnuO0mTkSPY8wP0QAvFPbE4LtffENWXiovMDJgtvS5wS0fTblJrOcoVvWVEevVRK43uKHVwt2ZzORDIAm42fTrpQmH2LO8xPvKI8WF3XhfzyRiKInD+IAaOun2JYsggGWG+8lmsPA8u6PqfXrH1+UQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162346; c=relaxed/simple;
	bh=/By8nYT6iw54kC+bLhCJ8aUugXIychxqeInoEEMoxzs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=bRQskDCM8hOHfnE6O+2I6ihhhJ7hOcDQkT5HleCa4seTpiGXJyFUOm1WBUSGv2c33Llc+8LGB880N46dvdw8NtQtqksq/c51DoCzbrCaJ2pLq/Q1eeMSGkS3c2ysbwC0UUOQL6G0QO9VcUaf581bRF35v3uyKLwRsnOy2GgO01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKzFlZ5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKzFlZ5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C8F1F00A3A;
	Mon, 22 Jun 2026 21:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782162344;
	bh=/By8nYT6iw54kC+bLhCJ8aUugXIychxqeInoEEMoxzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JKzFlZ5b1FEaDQOWyOMD/dfRYHMly/6aoWrX3MLBR5/YzKISsVZy2qRF1DKJaJOy+
	 HhDofDrNQb/6W44wlBKJNX4JZvbJ1mC2o0AMa07RU+RDunXeY6hGDXdYfQes9s/Wze
	 pKLh+GysWkPACPKTJhc++fUb1j2b2L+KoGPSR01BT08+hAWiGqSTTfn26Hi2neIQVH
	 2+L2uS3a7IkG6FVwx83A6t3Ilhh7kwv/UgOUb1DUCNvaul+uFsvXe1cdB0MNzCdgFd
	 4TuHTRsRZs30uNAB4uZEOt4lAkiYtE72Fl3vHyED7Zig9SI5OLOdVr/AHQrkrPWGyt
	 nY4/M41qJ57EA==
Date: Mon, 22 Jun 2026 11:05:43 -1000
Message-ID: <903233e7c06ee5f3ea843e5b923bb7c6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.2 1/2] sched_ext: Make kernel/sched/ext/
 sources self-contained for clangd
In-Reply-To: <20260622173904.1169407-1-tj@kernel.org>
References: <20260622173904.1169407-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied 1-2 to sched_ext/for-7.2 with Andrea's Reviewed-by added.

Thanks.

--
tejun
