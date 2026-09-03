Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9639F184;
	Thu,  3 Sep 2026 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460931; cv=none; b=BI/O0hDSaMTWTxEaaiBpwSSiXus7oqX/Z6zpQRmkOzfC7Xu7E/eUbmNKW1K48ErcKo8rOMPrM8KAbPJ/EzzPNR2o8oiWSEHmJ1dYIUiDAoC8NbMK+a2wYQ3DFWqKAtNIZYg0c9JxWSFY7G+oMXQnbCn25rG0XBvyk3oSV0LRIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460931; c=relaxed/simple;
	bh=P50b4hlScisxxQ4oKvwHZc3eo16gT7JVBiIbwnOiNRU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tFKv1mxuhvnItZyHQfGwrRnMvl4PMh++498GKeaAR66kX9VxoTGAeBe33sq3QBG4Os12abdW2VgCCYe6tms2hE0CC09TmRc7OoiXjLxbnoOOsLYuGXE2l6Q1roJ0co8WQCw741lBPWSu7e3OhMkPjmwkI44ibHIxg67xNSO4TQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVqZm46T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVqZm46T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AAD1F00A3D;
	Thu,  3 Sep 2026 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788460929;
	bh=7Pewtte2wJXDcBNCp95J5+D0hRZBTcN2i+RWLElcVWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WVqZm46TigzotnN1Rq06VOXLCVuWvJs+7aJzMiv6mvpamlHf4QtMUn8YpGslpPGKi
	 AJjCSWeoo9Vw2h8mXV4PECV+Yep8+b79XsWOfQ711NQ58UGK3Nc756IADiKP2b5NNs
	 8fye2CkuaPR+X9M2BLRhlEJRFYIiI81FI/yl+dRL+QDED3L9qQt559elIeIaVFpyCV
	 lXE/mjoTBTDXAsfqkFnIybMyUk4uHv9UI777hzPevDX4wJoAbk0yo0k1bh7P/hZL6z
	 M9PabIQsoJirKudJSCtTXA+bnGxf4Jfsd8zvQi9kSROCRFtbNKQ03GNoNSIrA1SFS9
	 AHlrtdHWdeALA==
Date: Thu, 03 Sep 2026 08:42:08 -1000
Message-ID: <7567d46cf1bbae3377b0c84aa5e4a030@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sched_ext: two more context-safety fixes found in the
 NMI kfunc audit
In-Reply-To: <20260903032953.659847-1-liwanwu@kylinos.cn>
References: <20260903032953.659847-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Wanwu Li (2):
>   sched_ext: Make scx_locked_rq() return NULL from NMI
>   sched_ext: Protect the idle-search scratch nodemask with irqsave

Applied 1-2 to sched_ext/for-7.4.

Thanks.

--
tejun
