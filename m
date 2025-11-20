Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866183B2BA;
	Thu, 20 Nov 2025 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658120; cv=none; b=GBYRYtvo0rFVJFAsXGHp/jSX10EpXuD1YPYy3FfjV/t2y7dlBa4An8lS7Ar7heG5pKByR8Y8wEBiWGxOyRaWUj3RUeaex1f309EfLBTC1UocLfEYdOwrDR3CDrqrUoL/asfKQc2FzcDLOOUqfbnpJUoS+tEqlt8JcU7cqonhL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658120; c=relaxed/simple;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=mmh0tF2BQo75JJDiqBRNR04vxrLgpYrhXjzciEdwCLoiZ1G8QJZn6SOsOzKNn+o9K+H2XIiARnHpIjm18H6hFVenZD3ebOr6X5BI9hzBC5+Dah5uUibB3YMWPUadm4PvcoX0prdxkqJZ/lws1IgYJRWGVXF+yON4fSYG/2guowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBct64e1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBct64e1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0493BC4CEF1;
	Thu, 20 Nov 2025 17:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763658120;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qBct64e1jqdY0SlQujwFGZ3vG3Zi0Grc/q0M9Z5mw6LHVSwNNllngtzYLPxH1t2gl
	 DkODVzY0s+7g0btGhoRMdr8izEmE0WtcjX7YizPcHpP3P8CQT/kK6kpAVKCL1eCAr1
	 aPQaSEuzPjxnoBLhKrP5LTU6VN/yggXLVAO6j5LmZ6yOeuMrMR9Ngu2ICjc1ztQfiY
	 BVNs7+/lll62DEytNRgLyU8359xM0W2SWsJf0UMIg4HW+idSTV1U8gZ0kuiSPvxJOP
	 e5nV1Ucf7rdN6NNcFRYG3iPxKK00tSyf+dttK4prDcwDbF5oQzBmEaLpNYwZcfd+Wp
	 b6aQl7tRanasQ==
Date: Thu, 20 Nov 2025 07:01:59 -1000
Message-ID: <ad32baee809d34e3d9427994335b6c76@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Rong Tao <rtoax@foxmail.com>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Rong Tao <rongtao@cestc.cn>, yangsonghua <jluyangsonghua@gmail.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: tools: Removing duplicate targets during
 non-cross compilation
In-Reply-To: <tencent_67540C5FC5463910910C6E855AB3402FEB09@qq.com>
References: <tencent_67540C5FC5463910910C6E855AB3402FEB09@qq.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19.

Thanks.
--
tejun
