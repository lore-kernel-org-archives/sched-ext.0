Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0B320A24;
	Sun, 10 May 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778450138; cv=none; b=dIhDfHtT5BlinLmF1Uz4OChZZlDWFgFiSsWYJ0sNHC1/7/RqftiEBR/fF90OwOdm3NrtboSjmLIVThWpoD1Qo9TUYqQsY/H9xk2s1Yjq1aRh/sfKUz2KC8xYhDLaNOpXN4VQa0nWGoZJsvS6opWgDOCHOx7Wj2r/xWwQ+W4gMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778450138; c=relaxed/simple;
	bh=0S+BjkPgvhogjPlIfpS1Y2yG4dUvpCB/AeEDDJZEZOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq16Dys+kM30YalWhtTFOAudzq8HQnCmoW3lmG1dQGraIJXfgGQG8vmdMMHEBYp3NHHjwqGsbf8kwQ3g32ijbNAxbwnPb+355Ci5eCJytlVflIlDNNJkm+OecEdFVGSVgJvXAVFY6xHX3+iSqNK1R2LeIzuK3NkIK53Aa+fDdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO5uGBWv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO5uGBWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBCBC2BCB8;
	Sun, 10 May 2026 21:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778450138;
	bh=0S+BjkPgvhogjPlIfpS1Y2yG4dUvpCB/AeEDDJZEZOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hO5uGBWvOTwcUzILn59ZBLwjFHcmUvkWZ7REuhE2GAN1fg1QhtYZOvDGVRtSV9I3z
	 V79xDavpIsURBNFr8WEsbGImknBB8ZUTfKCQU8BCkVDoQwMh1D8hXdWyYB0ST1agLp
	 0OVMLd/3WeBg+B651PnhzmTPR2L3AzIFN/sy1MdmfL9eh2EENuMAumKmXanxaYjMDl
	 mWT9/RedEEDl5I+/bMECVGCc/6OKKT9T3JBpMHHPoowzMKrin9qqI7IHQCSJcuAboQ
	 zT+tpaSy9/Jc8MmgDAZawCO/4leRR8yTGeGQ9f73odJfrn/m74iMKBAb120pWHBzbh
	 4McYNqxTw10vg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: emil@etsalapatis.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET sched_ext/for-7.1-fixes] sched_ext: Fix sched_ext_dead() races with task initialization
Date: Sun, 10 May 2026 11:55:37 -1000
Message-ID: <20260510215537.2568584-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510074113.2049514-1-tj@kernel.org>
References: <20260510074113.2049514-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Applied 1-6 to sched_ext/for-7.1-fixes. The merge into for-7.2 has a
lock-ordering complication around the post-init block; addressing with
a prep patch on for-7.2 soon.

Thanks.

--
tejun
