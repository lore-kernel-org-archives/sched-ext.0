Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528024BF947;
	Mon, 12 Oct 2026 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828093; cv=none; b=XrrcvtO7xAJ6j7m8otEVdB1zu2nPCf8wEbei7FaAeHlO22YmlQ4G+FzN0OluxwOyOGz9yUADztQZcCQtv2qWpKNOrbXTwAg3oxwOXRJ1blrsu2aSbSU3dTeFkpO7HKTMR4RDTb0vj9fMRvdJafqZr6e/lOzbbSHMb8s8XmRGIng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828093; c=relaxed/simple;
	bh=CNNqk74Jk+Qv/97fbMaYeKcgzQGo0orFovFeNDyOiWA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=NiLnEMgT7IdQ7BZD2cuRFDuJ7lAsEIyasPw+vizdIYaSUPVdt6celeSgehnMgg3o16Z3PkYOVoWhJzM/hA+urHdgNCBFuvbdXBKTHLdGZtHdHIoZxcnQNUddduYz9Ogwm+J5tJt/IZyuuO0/NOZ8KYmF7+vPLuni0APPqEyLEHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkMV645A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkMV645A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D7F1F0089B;
	Mon, 12 Oct 2026 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791828092;
	bh=fV2FLDgogyj32n1VoiMHeyfDBFQAFIKSAAd+vaJDMrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RkMV645Ah/f/j5dWG+v34P7F9oVUlMJERnIW0EWNL1E9gXQpdn6dQ4Y8LbUsVtig+
	 xp/yjTbbKq+YawDsVxb8ocNc2ckbTFCTgayTL3v49pgsBPCkzj7FOmTSAU4Qi20tdz
	 3jZIwp46ndmY1Md5IoWTxf/hah9lXhnKLPxF9vRaMkA/uf0ZAlDWmiMwwpil2R8GZG
	 qaP3QH2nKo4O3AX9oK5TM74zf+LV7YvRm6vW5kGdeeU5dW1QJplROSWmrXawQgkuMn
	 NTMFRD1qdwbkczs0SBE4xWbntMsNn5ofheDIq3IS6zBAnmoroBGCzk0zjVbrIz01XK
	 HZZ5s65/DnLsQ==
Date: Mon, 12 Oct 2026 08:01:31 -1000
Message-ID: <467bae1dc17e2d0a56e226f3c756fc0c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Samuele Mariotti <smariotti@disroot.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
    jpiecuch@google.com, shuah@kernel.org, sched-ext@lists.linux.dev,
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/sched_ext: Fix build error in dequeue_remote selftest
In-Reply-To: <20261012115928.1372317-1-smariotti@disroot.org>
References: <20261012115928.1372317-1-smariotti@disroot.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4 with the Fixes tag dropped and the following
tag added:

    Reviewed-by: Kuba Piecuch <jpiecuch@google.com>

Thanks.

--
tejun
