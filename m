Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1118154654;
	Fri,  6 Mar 2026 04:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772770650; cv=none; b=RbYfL+BO0zxrrfy+WtBm6XTVN4lIHouK1iw+MFrcZS/Z78zlRtFJnbnXtpYrulQK/bm9/u65nIbOVlvtbggmmMXuVRNHVVOgVk1+pTMa9XD+Fudi2yq2xdfXOhGWWjfZk4ioKQGsGTlh+CuEmDPff4F99bwp8KFk0fUPuJCt8kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772770650; c=relaxed/simple;
	bh=87F4juyntLJw7q85ouCwdXU9YN+pH6qZQvwpJ8nUod4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=XzVkQbGW+CRVGG+1KL3MCqqAQ/XIgHgmpq/dXGi1cgTLc69De4WGz3rp6PPmeiUxc5XeHPUW9hiU6nIdCEVpWuslJtehff4cZjvIKNUBAbqcJVlOupkhwqFYvesflIDkafchCynKeg6PQo9U0xEImr0IdJ+tTKCnnwF798vNPbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAgIw1wz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAgIw1wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B18C2BC86;
	Fri,  6 Mar 2026 04:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772770649;
	bh=87F4juyntLJw7q85ouCwdXU9YN+pH6qZQvwpJ8nUod4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RAgIw1wzrp2GDmd+Q9XJJAb51usr/AOQ/ID9SJi7N+rWDs4It7wjRePnt2DFzDoNb
	 ubOqSiXSrsiAsPZKHc0Jus4xYtYVrtybGM0fG003egW3G4YbLdUKLd/AKGvTMDxc7u
	 Fq//eeabU1rIZ8kyrcynkW237iyeiIxfgbxM+I1xLBruySpIWD6//mTIRVX0QzTQIz
	 LTK7XCWygDGHXY+j19wFkrBuyJwNUIx/jM7rm6aSNtnYvmSMlCA0pYykpWtAN4Dcy/
	 n+E5v8Vdy3/bl8VrZEEiNsQW5+sPaY8QGhFscqfp8uFSDJR5RZEosediftEWmcLHOE
	 85OoKMe1+D7uw==
Date: Thu, 05 Mar 2026 18:17:28 -1000
Message-ID: <902fc7f24a9fdb5699540bf083583995@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 emil@etsalapatis.com
Subject: Re: [PATCHSET v3 sched_ext/for-7.1] sched_ext: Implement cgroup
 sub-scheduler support
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

I forgot that two of the prep patches are not sched_ext proper. Will route
those through respective trees and retry.

--
tejun
