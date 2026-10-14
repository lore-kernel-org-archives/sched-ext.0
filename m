Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C293E7159;
	Wed, 14 Oct 2026 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014639; cv=none; b=sq3fIzIaz/SRc7QaUEiqWha+tLZ5AsKvlSxM9Ij/oPYahg3y71tuPZMU9JQ4jEo1G7uEGNTbyUJnRB9eQwHCprvBLOALHqgCF56idCe6/evG9Db8dpMP5T0zrIhhjIUGEGfv47zR0X3QJBFKfqA0AV88FHxtATvOQC8cDnP1Fys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014639; c=relaxed/simple;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=CXCQf8ELBz6gxWMGPkQRhUEhyyRnTVu00Uip6r9OAs1G1zih2ZUoLJNQ59jwpy4MtdkOE27BK3Ik5Di9PVStfqSjrdB+jeoVhzYWx47Q4RlQe5m0MoxC3jxN9AvelPoB3zdGFsCe8F0vK2UWFoIX5T8BbaBEnrgNuC/XMG4zag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhjh9jBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhjh9jBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FD31F000C4;
	Wed, 14 Oct 2026 21:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792014638;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rhjh9jBmPLYTa9h27itrdfumelB5x9nl0GL4wbLUE4w7eb7YOVcAPk2IiqAmN3A0U
	 RlEcxIc25yOBY+ULUESHI7DpDPyeuwTgroNxQzECm0pNRCx3LCqsUapDoQ7Vk5t0Ve
	 u+EcchljAO+70hh0c5tNC1E3odCo2tbaXx+72GhjSdi8NXeJG0Lmsvy5WLrptZIOfZ
	 /6T7V0WQd7SNHqUViBQgf5xV1O24R2bOL35d3zHqTUqYNWPJ2NEmuvffeVKr9TA5Ip
	 JoKtQIiIcuXN72E9deNvELE9x/YPICw1FGR49gmUjZn7TE3zuxUUCzZP2fo4orMRO1
	 o8PyXCktZQOWA==
Date: Wed, 14 Oct 2026 11:50:37 -1000
Message-ID: <5b3d2c576222c62738b7006d85f96a23@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: John Stultz <jstultz@google.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.4] sched_ext: Keep proxy donors with slice left on the local DSQ
In-Reply-To: <20261010090621.184717-1-arighi@nvidia.com>
References: <20261010090621.184717-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4.

Thanks.

--
tejun
