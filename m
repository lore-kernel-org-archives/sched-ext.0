Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0380C342528;
	Sat,  7 Mar 2026 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772895858; cv=none; b=UkN9lEtKKG86UY5MQ62IPmcMQaliRAPkw2H04FSeYuSQs4CpSSxYlJZyXKxbZzUEwxYtBapMbhMdODc3MpN1/QYEFigupyhRWy55MmsdcqHRie9WLoBG3L891+P4iNNa2M+ZVXtU8CgQFBtfIRDnizsp/sEkY2INq9KWJXdlLS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772895858; c=relaxed/simple;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGlmnsPihdspPzISq1RmfELoEBVUNXwfUqaAvDZRIGK4QkwjlUOpdbW+tueKdp5Zmh8ZK8ipzy37ePMVnRs3RoLT4dd8A2tMBrTnfpGm1ka1UqOpAD8WhWYes9nqEjAEczb/Xc71Y1045IfUxaCzBZiI6awqe3XrUROZwq4hE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rchPuYMB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rchPuYMB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E4EC19422;
	Sat,  7 Mar 2026 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772895857;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rchPuYMBcWk2j0G2GZQMyejP+Aoq6I1O82xHVbmoYGaeEl82FsFxD5Znh+ELyR/SP
	 zPLCt/hOftX8gEROvPpMgdCk5c7aqpu8GcaVTTiO24IaNF5KyvFWEA6tq2ewGQyC94
	 kQLeTGOp+t7QHr4AC/iSSjIgwm3/pMqbu2MOLAV9Yk1nGlukHptyGjdfcMk0DTwoAW
	 nkodCvtsrp7s4RlcKQ/zEFcjCrXOXEkqYodFIUymaGN9gGeGmDNbl+bLv2A6pFPs4F
	 V/PeJjduyACjDr2fNXfVKmLDYps2FskbAr+OsUN/Xi+BeGELTIWFwWMfqDMfRM+y0K
	 cKMy7JOpOfJKQ==
Date: Sat, 07 Mar 2026 05:04:16 -1000
Message-ID: <e43a463417a1bc636b2c805413bb8aff@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.0-fixes] sched_ext: Fix
 enqueue_task_scx() truncation of upper enqueue flags
In-Reply-To: <9b72570da1834f89d8f6017ce3b14db0@kernel.org>
References: <9b72570da1834f89d8f6017ce3b14db0@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
