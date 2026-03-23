Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1440DFD5;
	Mon, 23 Mar 2026 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774225969; cv=none; b=dWVG6Dr7y4x7htoglxocOiMknn0d47kF4Ktt5CByPRzqS0YYyTIhHffTysWiyfGe8YkevMBikfoM9r9kgTatKSHPogWv7018yymELl2WW0KjfoSluioBzRV+FuVeQ21xI6ugYid4lrnm8dHTxDYzrD7L0licSiUQFJ7ltU5LJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774225969; c=relaxed/simple;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=eOhTaY5VlZCBZqcYn0Uq4oXTcmCpT5rle8lNH3jUVa0l44HQpGBq1z9FlVslQ2yJsOzX/99iTONRvLyUT4e6B7zmTMsHVbbMiDo2P4sRC6dojyUwh6znAtWuCxHIVmNK4jPUzqDA6HXFs3aQubrvs1XiJDul/ZJL2gEy6vqlKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOkCKyQE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOkCKyQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EADC19424;
	Mon, 23 Mar 2026 00:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774225969;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QOkCKyQE7opBvKvh+XVA2ljJGp/vsL+GsvtvjQAnaJOxZYY/Xdvfhc9xNG2DZ9Ggh
	 DpkMYUvDyxQWU78kwuYoZuTTApxN7a73sJ0+pSWW7YcsP0pjj/8Ug/91d/um1o8lKg
	 jG38tEjoJgshYctP/KE0n1XWltqQInDLgUo/NvJx8bT6KVIgwzOHnL+sP+b0dsw3xA
	 0MwjV6RvFpI5JOy7mrNRoMIP5UAqJvNGHn9cR7VpFR+TcQt0RSSJ2yd988r1OwuDfw
	 VRomxUSZ824BIu8yJ+HPceNYJ5NuhH/RRXXILbHm4Xrjn+4xfnRTgdwPLxGxgg0rPH
	 ouuxs+j3UilzQ==
Date: Sun, 22 Mar 2026 14:32:48 -1000
Message-ID: <b591b81576d254e6b10e523238da1a34@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhidao su <suzhidao@xiaomi.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 peterz@infradead.org, mingo@redhat.com,
 Su Zhidao <soolaugust@gmail.com>
Subject: Re: [PATCH v2] selftests/sched_ext: Add tests for SCX_ENQ_IMMED
 and scx_bpf_dsq_reenq()
In-Reply-To: <20260322073533.1022768-1-suzhidao@xiaomi.com>
References: <20260322072051.993347-1-suzhidao@xiaomi.com>
 <20260322073533.1022768-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
