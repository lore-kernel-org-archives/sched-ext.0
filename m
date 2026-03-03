Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C08386C20;
	Tue,  3 Mar 2026 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525212; cv=none; b=Wrhjqqv4MA6IrcbKNHzbAedRpcNPFHhw9qAO8oY+vTXyeLNYIj/xygD4MjkTfjQpm6cUUSDXt1x5L2mMJWK7jHMNmh9iwp086Pz4XRVz9VK1/oM64Qmrkuh6VQ+ndhwiYboHIwMKcP+pB3KSFsO32YAP+rK8YHf/jKRFf2l4qp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525212; c=relaxed/simple;
	bh=csNriQBMGjh2HsIQExblqKsd8XAaspsnZDt0xIs7+Jo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=RwpVt+STNtbu83B4x1p57pJ+v02/aV4Wxpx9MCwbGFx3krp3saMAZTgQrVfFIla+mjgkWK67evZKFxnNsr+8PTZbqvEeXp1SA/NTMKcF7f9UYcoX5oIiP/00XC2KkroCbrm3uqfCyB2J8eaFeQcyLQyt7T5tv5ZOL/vGc3odaiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zpb0cYkZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zpb0cYkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD70BC2BCB0;
	Tue,  3 Mar 2026 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772525212;
	bh=csNriQBMGjh2HsIQExblqKsd8XAaspsnZDt0xIs7+Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zpb0cYkZcUJ+4AwkP0wqGQc88D2lSn3vFqq5vt2oMfH6GgirL0ECQX5eqzp3Uaw8s
	 jms30YiLzTua1XYrKZ5/NXO67tY/jFezcacr8u9ox7Qv9WYnkppcvLai7kWia/nAJP
	 jY75U4TDhhNQ585z03gFbQpODWAFu1x7OQ52w5Ow+kdJuL/ekOBdqRaj+eYc7e5bVo
	 SyUxM1smN6k1ahH15r9zcLGmSr2eNdkL+Le0OSaHsPCf7jS3Ro89FYWokoJavPvscE
	 sNQhbmu3SARxODBzF/ohy683sYXGb+02X+OiwAPKLyYNyOnyeDNQA0E+FTe52LHT5A
	 rc21Qf4u7QgWg==
Date: Mon, 02 Mar 2026 22:06:51 -1000
Message-ID: <a3db8e7c83cf42834a441e385c2844a9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: Re: [PATCH 0/3] tools/sched_ext: fix compilation issues
In-Reply-To: <20260303072317.76035-1-zhaomzhao@126.com>
References: <20260303072317.76035-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Zhao Mengmeng (3):
>   tools/sched_ext: Add -fms-extensions to bpf build flags
>   selftests/sched_ext: Add -fms-extensions to bpf build flags
>   selftests/sched_ext: Fix peek_dsq.bpf.c compile error for clang 17

Applied 1-3 to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
