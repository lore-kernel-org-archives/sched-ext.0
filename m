Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA648BD3A;
	Tue,  3 Mar 2026 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572935; cv=none; b=FqGGL9wOjv2ts4yi0NobFVEeLBqPuDb1w7Fl6xEmpNNw+gL7UgwDSaXJQZjpw/MdZU0wENJwbkWYd5lU6GOakJ71eUiVCBKrn5oJZnWbSXb3laTJK1LgQwN1J5N6eEi9J6gMB2Y5vS+yC/4RFAPjJXy5zIEwgWA/NttrfxYU1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572935; c=relaxed/simple;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=r9uxZk2bpr8rdq1TAZ4SZ2Yeu/coQ88nEI12tkOhwyf68DskZ34TC6dTjKr5xxsIgeljQVSxktwIg/L5fueuOv6iiVMlP78yFLJtaT7QY8ADxqvKJTjj2Fx/fTP/D4xxDNzX5bn+wDKVD5ANBThZ8y6TSJi64C5TgHEe6w/mUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7hqWrvc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7hqWrvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03163C116C6;
	Tue,  3 Mar 2026 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772572935;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J7hqWrvccdNcuYPswkggxEvYSTezXQikuseyqDbj2McaTVH08dLpZ0oESnD9GCcA1
	 lE3FfAmHYTOBFyWTYpdJHDh46aMm7emUra82yDdfOb8xhNqxCIaQVJyOfH2HMNFF6Z
	 sfbLlhPlnTYMH8mQteL5eJQlR72iBHzhZoJEGbV+Jirr8DgviwjFQtWbCHSQTWr7Hm
	 zvHw5S0EEtmvFpyGuS7l+iY4UEfCvTJwhdcv5tJZ0l5Qt+XpmPuI7XjXOsfn4bB6dU
	 ILdJySLdccFuIvAyvttsfuiJXMaVGkHJdxAFF5u4dLNZGqsKTjxGGaW0qoSpQv+JTd
	 ub73pyHtfKq7Q==
Date: Tue, 03 Mar 2026 11:22:14 -1000
Message-ID: <09f4a3f326c6834e2ebb7e02e1a40cc1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.0-fixes] sched_ext: Fix starvation of
 scx_enable() under fair-class saturation
In-Reply-To: <85a171ba1e37f417fbd7e74afe56efc4@kernel.org>
References: <85a171ba1e37f417fbd7e74afe56efc4@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
