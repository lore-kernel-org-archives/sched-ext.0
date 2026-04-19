Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B472472AE;
	Sun, 19 Apr 2026 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776621193; cv=none; b=jyG9FfUfaOQcBdmSieoYADsJVj+4mLHN8tW0lSIJfTKAVeEdXaIqCoPQyDe3FGSbnFXO5fnAuu14FywiwaMjVf7NvJKq+PlI9JMQ4OBhauUWMWiqqsKlEMoJ5ouLUiByEcI5H5k173yZvwHfMJs2EtUGL8nFfhkankqTTPgVZ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776621193; c=relaxed/simple;
	bh=BpUlTZdU6iKLJyHy74DVgUbJssdVdz1upreAoZlF8RA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=FLA+qE6uepRof6jbVlbvgOIrRJdwn2yUDUDIauyGk9sUWkg7ErqHrOlwsuXsEeKIdf++HVlIJORicLywZ7ljcfwucDeUxUyvsm6BeuEVHl8FTEJbeEQlIZv5epiC2BECxZl9hSCju/YEZapE6qTZKv/ylravK4jcvK3ELdtFBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5gb9D9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5gb9D9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD5AC2BCAF;
	Sun, 19 Apr 2026 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776621193;
	bh=BpUlTZdU6iKLJyHy74DVgUbJssdVdz1upreAoZlF8RA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E5gb9D9drTvgS9/9kibAscy9+TlyKBxI7KfCOc5PLXG0NGIALcG7JXGbwuwVXOa6s
	 YOv6sNXj9VxeWXXudlO68hOSRrn257amKmmEiloZHK201ud5b04bqlxcHt2IH4wQez
	 KC0r6gS0NiTJZRIhY+Zyiz6hsVj2ecvnwsQlmRE6SnMe9G4UUoimbmDm6RzA6WNnN1
	 S/xi7MQMt7T0d68iCQJD+GeWqZmIIBCArXZwFi7HsA58iQAJCQBHh4yv2yRnowujuK
	 Ql0UBCX1RvrI0BbK0AbOfyPxFOkOez1hK4SjgmbJBq4o5end+aXGuCKGiKRofBzjIh
	 Zu0EusImrkTJA==
Date: Sun, 19 Apr 2026 07:53:12 -1000
Message-ID: <bfdf1d6066eb84b84f0a35dccf41f68f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] tools/sched_ext: Remove dead -d
 option in scx_flatcg
In-Reply-To: <20260419163619.254122-1-yphbchou0911@gmail.com>
References: <20260419163619.254122-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2.

Thanks.

-- 
tejun
