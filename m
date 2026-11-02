Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636166;
	b=n3+JtFiNeHYXe4DgLlfYylUdossaa5muF9OqURHFD1+LcsxvJ9zfpCrU9IvDY45XNhE8
	 Xm7cLwyppWvTn8hiHas45DA2E1Zkl82Gh/SmQXyb3GQWSAGQNBADaWMmR2Ro8XI2UV5FA
	 JpzhCX8WUJL1l5qZ8MSjozFG4GNw8E5cENDfib1n1ZTXIUoDIe1kKyUAyHArLzeaTxo2w
	 cmlV2eUbggQ3ZgcmSnxfQV7CUnYrowyIq+TZOI4mhyk2Rseyu5/Y5zb3e6wkbOa/DMzDI
	 yIj0ZrP2XhD56TpN2phZpI8AdJLIctfsEjrc252aXuXLfoD3AW958SRHQ3dDybEyrCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636166;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=60a0/HLjQTWhu7YxyY2UEEVoE9Eqcv8bbTKkNoYxrVU=;
	b=tltmze3wxRxAGbvz6JRCVmShk2osS20BB9JbJIFB2omHwq7GuXg1vZAyzKJEZEsokxHY
	 z3s7vPj60tspD0M6CqeQ+52swoCdL9YLUaAFYD7WQI0pbNxLoKMsDdHMor+KDus9IuXUJ
	 5ZGAKwmr6h1aHK0EYNFVlvfB+haU3imfAUZSEJwcTdEnDQUmqoYLcXofeS9MlXlBq9P7H
	 2HXehsJ2UugREsBid6Fhicf7ob/PJuisrYtByDU9NJXrTDwDiAXyrHrfUHc68bkEQ1DRb
	 eI0EauSOQ5fRJwAD3bMTbydKczp22Br9z2YH9IzH43WyZm6fTdcqWYSytSjU+7AysNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FiyyH8PJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D52606AB8C;
	Mon,  2 Nov 2026 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FiyyH8PJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4454B1F00A18;
	Mon,  2 Nov 2026 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793636165;
	bh=60a0/HLjQTWhu7YxyY2UEEVoE9Eqcv8bbTKkNoYxrVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FiyyH8PJKpC33lyHFq2gD+6Jo/ZJe5p/l8ssoj3XCnAxSu9WEuZCeKT75tJbA6WnV
	 AGP6D/YBciSmBWciN05AaIk/GGtRjwJq6k7xVXosvC/owKmPr+CKG7/u2Q0M/31w8a
	 YBH7WtUetHNXyaibZWmlEqDdQN16vFBsNUdTBlvA4pEhi+haCBe6LuMReIFIgJ21lU
	 l6uiC1A7f9+qIG7z227Q8Y2b3XSMZdTfdorwiffsMj0fJ+CVhYZ7HF8vzhyfNjfbjZ
	 fv/fCKLb2WrG6myfSr65cEhuzuSl7jIYVtxhbCLKRb55uoDgWsTr2yAXs+Y/yNu1w5
	 wNuPpYfxm0cUA==
Date: Mon, 02 Nov 2026 06:16:04 -1000
Message-ID: <1abd1d80c29698e76b558506ab68e2e2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.5] sched_ext: Say "hosting" instead of "running" in scx_exec_sched() comments
In-Reply-To: <20261102080259.1509843-1-tj@kernel.org>
References: <20261102080259.1509843-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.5.

Thanks.

--
tejun
