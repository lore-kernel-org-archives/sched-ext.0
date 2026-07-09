Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484354499AB;
	Thu,  9 Jul 2026 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633238; cv=none; b=HchDf5D0vk8ehMoT/T3vOtBY673cYdtxr5pRzSeOMz63gYUCjHCbPadsF1OZ27Iy3er2e5V5nqGv2dNddXOolA3EFOYa9L4Gpoct4GqzgCOdAKt9y8FE0QSs2MTE2+CCHQQDluyKeVvjw3nHVWOMHwt8RGlKUWrUdOhqlBpr5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633238; c=relaxed/simple;
	bh=CRFu9C2Jty5hTt14NfHQPV+2khBS/mhlTmpwDKZLXok=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=XYDWkrJDw5T1g54hkr64DQXZN0Nd2xBo4wpUohEBmWMEV7WX0/6Fa5rQvCfkNtobzLwept5z0u7dxGWjF+Wc4kiRr8FC+7Jaz7X058WDWcbgpJjlrPI5Z6aHSuESdjuv+h8vnVlcVSj4rHbQbQp7RSUaHJcOsBo30uv/DY4aku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3R9sbfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3R9sbfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8AB1F000E9;
	Thu,  9 Jul 2026 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783633237;
	bh=B9fRwRwTmrLmV9tyNkfnk6s51FYkxnfr83PEQMkCqZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a3R9sbfy8b0WTMtWKhg50ET87VCDmvC1v6gwk58b4YC2ef1y0gs0WJdj6HLy6qELk
	 ClGblpE9VvGuuFeYi32AFYCpQcMjHG0dx85p9ZrpSPeQIOS6+m6HoggvcdgdN4qI1f
	 hHojvdPGEOe2voIMGFSmLCed44+7N7hE5tYX7mYIkFGdcaN9FNo4+p6pv6less5mV+
	 mkiPj7cCBkwPxG+tAmULPpx2r9XvS54dsL3dfOG3O3nGTfmtJpKHDH8mJD352JiZZ8
	 qBpzy8j1GKFCyuL8xZjeSZFDw7Yp7UmtLQFP8epMCKulewZYZKcAeyQOe1f1Zxdv19
	 Ox5/C4ENE/3Mg==
Date: Thu, 09 Jul 2026 11:40:36 -1000
Message-ID: <cad8f125d1123e45e425ffda45786043@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
 sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] selftests/sched_ext: Fix bpf_link leak on early return
 in prog_run
In-Reply-To: <20260709100340.706670-1-luoliang@kylinos.cn>
References: <20260709100340.706670-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3, with the Fixes tag Andrea suggested:

  Fixes: a5db7817af78 ("sched_ext: Add selftests")

Thanks.

--
tejun
