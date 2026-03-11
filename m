Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F32C0261;
	Wed, 11 Mar 2026 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263163; cv=none; b=hf2RsoTY4pRBbeFXmYP+eev6kpsTaJqXTN+5bE2D+7y1ICm7aUOHHN6WE4Rs1ysJz1ndNffp3eEmhhKG8gjReGJkSyK2IVpYmoG39LKCdaILRjqCFGTrW+fOoTDsgd3VqCrr5J8D6LG/jSCJwllTOlbq/vSMDL6qnHWCnfFfVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263163; c=relaxed/simple;
	bh=wz3MTUWksW7Sz6NElTpI+0xmrFUoOT7aCtHvl0HrT3k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=LVbEgdhVrQTfnPcLnzLwCS0aUiZmHgRtwZ/4FlEIJnFCDqdBYB3qJxRA0BjGVhQ+Itfp/DsW5Hq3Ex/puYVyEglu+iPnm2TQqRcr5ZqcPgIMvY5f514fgQ0wA8rdJNupLTmDoYXLo4Y1JSc7lr1YuLqi8SFwkGDtkh+okyQORec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPWUiwao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPWUiwao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20965C4CEF7;
	Wed, 11 Mar 2026 21:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773263163;
	bh=wz3MTUWksW7Sz6NElTpI+0xmrFUoOT7aCtHvl0HrT3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lPWUiwaogzxkdQTWyTdOz5dOD4CoARm/+wFO800pc+4pq6kF8LFxwjrZExowCIK1M
	 IQR71LJMrvr4R1yNrPOfUmWLMbxenMUchiQRvI9FFE122wy1jOVmWOGTZByjK8CY9a
	 JwEyAjM+YOCZJTaYa+sy4TEass91RR7x+B9ZKRH+SuZXfEX6sdI3WCQKlSJ/aFNBhg
	 lQiJ9ZrA5a5umJVio8jM2ykAuuRLsX4h42i+Ej0ZQ/+E94+gv/Al24SR5aABDl8FMU
	 8g9FPH558zFSWFwhvrew6MdWL8etHg29KxgUu1H44Zf2PoW54j8HrM8yN1q7HlPiQk
	 +u0aMNrvOcl4Q==
Date: Wed, 11 Mar 2026 11:06:02 -1000
Message-ID: <35c90cf37481714382313db7157a2371@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Fix incomplete help text usage strings
In-Reply-To: <20260311113407.451739-1-yphbchou0911@gmail.com>
References: <20260311113407.451739-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> sched_ext: Fix incomplete help text usage strings

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
