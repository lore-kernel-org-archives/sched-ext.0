Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0026A0C7;
	Wed, 25 Mar 2026 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774413177; cv=none; b=TcI8yFXxsElRCSidT9h58qieM5wBnb8WMni7/HcA+cF9MXi+UgZZBsowhgsRU7axl7AeeaiNmiVfFuCodTi0Nu0GobYAVpUWpfEx8UazveWRZ+OlhCQWnoT03C45ekbUgw+p5al+DUiLEMF1i9hoHBzygCm4xwy0Cx6/iloNIPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774413177; c=relaxed/simple;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SI6JbPxGYr4f5ABzjwtX5+Nrju7Fj5WzsNeeh0c6JdyhFNJb8LMS81vuPr4rU13OCGYU+kIt72obP3oorzkXD8zIfu0zx6LrLqvmI5PraX2BOnbbbY7mVIK0gbs3dUYxB5745fSqVTfF1PfgkGsgHLQces9Pbfv1D8Y81hL2G/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gerNsVe2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gerNsVe2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6A4C4CEF7;
	Wed, 25 Mar 2026 04:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774413176;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gerNsVe2RZLr7ymzY8/Tnvqs/IkuMUrI5BU4keUmv1EAeAsrLQdW+Ld3HFa+B+lVa
	 H9paQ93r4vhB2vI7z99QoscGgdo3+ftyt1iAstSmtChqTCBFulu5VlsLB1qokPAwco
	 ykbWnqhTAjQmDNIb9dZfuQsa3Qma/rrk8xX7CJfPaVt9M6IiyzqIyb7WHL2s0ipIYb
	 RQMtP5qxAF32I80NcvDidG8zwi0rPY05PLoO1unAzgh1dmMFUjZE8iOsZ9K72qShcw
	 nVmjFY2eDDk1IFDA34dHcDOwoNwNH24BLYCERzdEi3HQbe4mifZMKBtBpk1RcvpJFT
	 aPDuj7od5JHCw==
Date: Tue, 24 Mar 2026 18:32:55 -1000
Message-ID: <f92795c9a857e68958caedadd48f91fb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Choose the right sch->ops.name to
 output in the print_scx_info()
In-Reply-To: <20260325031100.22840-1-qiang.zhang@linux.dev>
References: <20260325031100.22840-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

-- 
tejun
