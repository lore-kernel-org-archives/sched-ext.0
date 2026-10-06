Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911738D415;
	Tue,  6 Oct 2026 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324880; cv=none; b=n8ESFsU8R2bl405A8mP7XX3RIWEDr3y2OjHC5oa/19GGubxZVSSSVlWvV6eY2XwHhb4uzWiUxSR+8Atimc2HZIiInL9PJajux4+4WzdgoIuEXz59SG67naY4qz6d99Ec0vU4A2QwS+l5BTzS3OtN+IUI2+7YI4eMRIUzRxW5+5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324880; c=relaxed/simple;
	bh=LOgFZ6pFJ14t2d6pjvDzcKRHWb9lcP65IPyKQCU4F9I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=NIL8xVMDwCqBAklVOc2h6N0l6YnR+ZKr3yXUSq1ypxMmmovlbJTCwEGadDJvLYSZdxv1ZMFrED5xmZeNeWluBSmb1YRL7bKzhSBxmUNtYIxEWRcat6Jbs+BcMNGJjosu+DkqaqO41JcZljAWQjnCgQ4YfN+MG/Yx+t4vwcVRpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZtLjTea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZtLjTea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C1F1F0089B;
	Tue,  6 Oct 2026 22:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791324879;
	bh=LOgFZ6pFJ14t2d6pjvDzcKRHWb9lcP65IPyKQCU4F9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NZtLjTeaf6BR0nS7aW8EwLzE92R3PoZhSzd99rZ3q9fiIgHaiIz2OBp1nw5sSLs/X
	 2YmQaayjLlkJFHyWwczdP6DYV+Syn8Ae8YdmEIM8cvxzAbrj8+AH/yYGxKP9mIheLa
	 voalojPn2jdSSNBVvqV55NkwrfFWStnPU3+tXZEXzQnOqpuXFCJsXqI5E+Rb1eVNBm
	 gS4vxI5KNuLL12jqPXs7N4yjQe5v5VREYHlW8hdI9VxiKU3liKhmcRZ4o7iKPBV75Z
	 8eDaVfGZ1de177AMC+BDosjQZ0lPtQ5FkzylPZiHGNthYBnpKS7S1BMesCzIprHOdy
	 Tb2XKsPPulKrQ==
Date: Tue, 06 Oct 2026 12:14:38 -1000
Message-ID: <5db00088481030c82f8ad1a6aa59e581@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
	Tao Cui <cui.tao@linux.dev>
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Clear a sub-scheduler's caps
 before ops.sub_detach()
In-Reply-To: <b46300eda6da03d56262fcdcbfc9b4fa@kernel.org>
References: <b46300eda6da03d56262fcdcbfc9b4fa@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, Oct 06, 2026 at 10:31:48AM -1000, Tejun Heo wrote:
> Applied to sched_ext/for-7.4.

Applying this was an accident and premature. I'm going to leave it as-is
but please holler if you see any issues.

Thanks.

--
tejun
